package main

import (
	"context"
	"strings"
)

func cleanupSchemaObjects(
	ctx context.Context,
	settings *cluster.Settings,
	txn *kv.Txn,
	codec keys.SQLCodec,
	ie sqlutil.InternalExecutor,
	dbID sqlbase.ID,
	schemaName string,
) error {
	tbNames, err := getTemporaryObjectNames(ctx, txn, codec, dbID, schemaName)
	if err != nil {
		return err
	}
	a := catalogkv.UncachedPhysicalAccessor{}

	searchPath := sqlbase.DefaultSearchPath.WithTemporarySchemaName(schemaName)
	override := sqlbase.InternalExecutorSessionDataOverride{
		SearchPath: &searchPath,
		User:       security.RootUser,
	}

	// TODO(andrei): We might want to accelerate the deletion of this data.
	var tables sqlbase.IDs
	var views sqlbase.IDs
	var sequences sqlbase.IDs

	descsByID := make(map[sqlbase.ID]*TableDescriptor, len(tbNames))
	tblNamesByID := make(map[sqlbase.ID]tree.TableName, len(tbNames))
	for _, tbName := range tbNames {
		objDesc, err := a.GetObjectDesc(
			ctx,
			txn,
			settings,
			codec,
			tbName.Catalog(),
			tbName.Schema(),
			tbName.Object(),
			tree.ObjectLookupFlagsWithRequired(),
		)
		if err != nil {
			return err
		}
		desc := objDesc.TableDesc()

		descsByID[desc.ID] = desc
		tblNamesByID[desc.ID] = tbName

		if desc.SequenceOpts != nil {
			sequences = append(sequences, desc.ID)
		} else if desc.ViewQuery != "" {
			views = append(views, desc.ID)
		} else {
			tables = append(tables, desc.ID)
		}
	}

	for _, toDelete := range []struct {
		// typeName is the type of table being deleted, e.g. view, table, sequence
		typeName string
		// ids represents which ids we wish to remove.
		ids sqlbase.IDs
		// preHook is used to perform any operations needed before calling
		// delete on all the given ids.
		preHook func(sqlbase.ID) error
	}{
		// Drop views before tables to avoid deleting required dependencies.
		{"VIEW", views, nil},
		{"TABLE", tables, nil},
		// Drop sequences after tables, because then we reduce the amount of work
		// that may be needed to drop indices.
		{
			"SEQUENCE",
			sequences,
			func(id sqlbase.ID) error {

				return nil
			},
		},
	} {
		if len(toDelete.ids) > 0 {
			if toDelete.preHook != nil {
				for _, id := range toDelete.ids {
					if err := toDelete.preHook(id); err != nil {
						return err
					}
				}
			}

			var query strings.Builder
			query.WriteString("DROP ")
			query.WriteString(toDelete.typeName)

			for i, id := range toDelete.ids {
				tbName := tblNamesByID[id]
				if i != 0 {
					query.WriteString(",")
				}
				query.WriteString(" ")
				query.WriteString(tbName.FQString())
			}
			query.WriteString(" CASCADE")
			_, err = ie.ExecEx(ctx, "delete-temp-"+toDelete.typeName, txn, override, query.String())
			if err != nil {
				return err
			}
		}
	}
	return nil
}
