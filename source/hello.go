package main

import (
	"sync"
)

func TestCacheFind(t *testing.T) {
	dir := filepath.Join("testdata", "dir")
	cache, _ := newAccountCache(dir)
	cache.watcher.running = true // prevent unexpected reloads

	ch := make(chan int)
	accs := []accounts.Account{
		{
			Address: common.HexToAddress("095e7baea6a6c7c4c2dfeb977efac326af552d87"),
			URL:     accounts.URL{Scheme: KeyStoreScheme, Path: filepath.Join(dir, "a.key")},
		},
		{
			Address: common.HexToAddress("2cac1adea150210703ba75ed097ddfe24e14f213"),
			URL:     accounts.URL{Scheme: KeyStoreScheme, Path: filepath.Join(dir, "b.key")},
		},
		{
			Address: common.HexToAddress("d49ff4eeb0b2686ed89c0fc0f2b6ea533ddbbd5e"),
			URL:     accounts.URL{Scheme: KeyStoreScheme, Path: filepath.Join(dir, "c.key")},
		},
		{
			Address: common.HexToAddress("d49ff4eeb0b2686ed89c0fc0f2b6ea533ddbbd5e"),
			URL:     accounts.URL{Scheme: KeyStoreScheme, Path: filepath.Join(dir, "c2.key")},
		},
	}
	for _, a := range accs {
		cache.add(a)
	}

	nomatchAccount := accounts.Account{
		Address: common.HexToAddress("f466859ead1932d743d622cb74fc058882e8648a"),
		URL:     accounts.URL{Scheme: KeyStoreScheme, Path: filepath.Join(dir, "something")},
	}
	tests := []struct {
		Query      accounts.Account
		WantResult accounts.Account
		WantError  error
	}{
		// by address
		{Query: accounts.Account{Address: accs[0].Address}, WantResult: accs[0]},
		// by file
		{Query: accounts.Account{URL: accs[0].URL}, WantResult: accs[0]},
		// by basename
		{Query: accounts.Account{URL: accounts.URL{Scheme: KeyStoreScheme, Path: filepath.Base(accs[0].URL.Path)}}, WantResult: accs[0]},
		// by file and address
		{Query: accs[0], WantResult: accs[0]},
		// ambiguous address, tie resolved by file
		{Query: accs[2], WantResult: accs[2]},
		// ambiguous address error
		{
			Query: accounts.Account{Address: accs[2].Address},
			WantError: &AmbiguousAddrError{
				Addr:    accs[2].Address,
				Matches: []accounts.Account{accs[2], accs[3]},
			},
		},
		// no match error
		{Query: nomatchAccount, WantError: ErrNoMatch},
		{Query: accounts.Account{URL: nomatchAccount.URL}, WantError: ErrNoMatch},
		{Query: accounts.Account{URL: accounts.URL{Scheme: KeyStoreScheme, Path: filepath.Base(nomatchAccount.URL.Path)}}, WantError: ErrNoMatch},
		{Query: accounts.Account{Address: nomatchAccount.Address}, WantError: ErrNoMatch},
	}
	for i, test := range tests {
		a, err := cache.find(test.Query)
		if !reflect.DeepEqual(err, test.WantError) {
			t.Errorf("test %d: error mismatch for query %v\ngot %q\nwant %q", i, test.Query, err, test.WantError)
			<-ch
			continue
		}
		if a != test.WantResult {
			t.Errorf("test %d: result mismatch for query %v\ngot %v\nwant %v", i, test.Query, a, test.WantResult)
			continue
		}
	}
}