def main.main():
    let t0 = newchan main.main0.t0_chan0, 0;
    recv t0;
def os.newFile():
    if else call os.newFile#2(t3); endif;
def os.newFile#2():
    if call os.newFile#4(t3); else call os.newFile#3(t3); endif;
def os.newFile#3(t3):
    call os.newFile#4(t3);
def os.newFile#4(t3):
    if call os.newFile#6(t3); else endif;
def os.newFile#5(t3):
    call os.newFile#6(t3);
def os.newFile#6(t3):
    if call os.newFile#8(t3); else call os.newFile#9(t3); endif;
def os.newFile#8():
    if call os.newFile#10(t3); else call os.newFile#11(t3); endif;
def os.newFile#9(t3):
    if else call os.newFile#22(t3); endif;
def os.newFile#10(t3):
    if else call os.newFile#16(t3); endif;
def os.newFile#11(t3):
    if call os.newFile#10(t3); else call os.newFile#12(t3); endif;
def os.newFile#12(t3):
    if call os.newFile#10(t3); else call os.newFile#13(t3); endif;
def os.newFile#13(t3):
    if call os.newFile#10(t3); else call os.newFile#14(t3); endif;
def os.newFile#14(t3):
    if call os.newFile#10(t3); else call os.newFile#9(t3); endif;
def os.newFile#15(t3):
    call os.newFile#16(t3);
def os.newFile#16(t3):
    if else call os.newFile#9(t3); endif;
def os.newFile#22():
    if call os.newFile#23(t3); else endif;
def os.newFile#23():
    if call os.newFile#24(t3); else endif;
def os.newFile#24():
    tau;
def syscall.getAttrList():
    if else call syscall.getAttrList#2(attrList_0); endif;
def syscall.getAttrList#2():
    if else call syscall.getAttrList#4(attrList_0); endif;
def syscall.getAttrList#4(attrList_0):
    if else call syscall.getAttrList#6(attrList_0); endif;
def syscall.getAttrList#6(attrList_0):
    if call syscall.getAttrList#7(attrList_0); else call syscall.getAttrList#8(attrList_0); endif;
def syscall.getAttrList#7(attrList_0):
    call syscall.getAttrList#8(attrList_0);
def syscall.getAttrList#8(attrList_0):
    call syscall.getAttrList#11(attrList_0);
def syscall.getAttrList#9(attrList_0):
    if else call syscall.getAttrList#13(attrList_0); endif;
def syscall.getAttrList#11(attrList_0):
    if call syscall.getAttrList#9(attrList_0); else endif;
def syscall.getAttrList#13(attrList_0):
    if else endif;
def syscall.getAttrList#15(attrList_0):
    if call syscall.getAttrList#17(attrList_0); else call syscall.getAttrList#11(attrList_0); endif;
def syscall.getAttrList#17(attrList_0):
    call syscall.getAttrList#11(attrList_0);
def os.fillFileStatFromSys():
    if call os.fillFileStatFromSys#2(fs_0, fs_1, fs_3, fs_2, fs_4); else call os.fillFileStatFromSys#4(fs_0, fs_1, fs_3, fs_2, fs_4); endif;
def os.fillFileStatFromSys#1(fs_0, fs_1, fs_3, fs_2, fs_4):
    if call os.fillFileStatFromSys#15(fs_0, fs_1, fs_3, fs_2, fs_4); else call os.fillFileStatFromSys#16(fs_0, fs_1, fs_3, fs_2, fs_4); endif;
def os.fillFileStatFromSys#2(fs_0, fs_1, fs_3, fs_2, fs_4):
    call os.fillFileStatFromSys#1(fs_0, fs_1, fs_3, fs_4, fs_2);
def os.fillFileStatFromSys#3(fs_0, fs_1, fs_3, fs_4, fs_2):
    call os.fillFileStatFromSys#1(fs_0, fs_1, fs_3, fs_4, fs_2);
def os.fillFileStatFromSys#4(fs_0, fs_1, fs_3, fs_2, fs_4):
    if call os.fillFileStatFromSys#2(fs_0, fs_1, fs_3, fs_2, fs_4); else call os.fillFileStatFromSys#5(fs_0, fs_1, fs_3, fs_2, fs_4); endif;
def os.fillFileStatFromSys#5(fs_0, fs_1, fs_3, fs_4, fs_2):
    if call os.fillFileStatFromSys#3(fs_0, fs_1, fs_3, fs_2, fs_4); else call os.fillFileStatFromSys#7(fs_0, fs_1, fs_3, fs_2, fs_4); endif;
def os.fillFileStatFromSys#6(fs_0, fs_1, fs_3, fs_4, fs_2):
    call os.fillFileStatFromSys#1(fs_0, fs_1, fs_3, fs_4, fs_2);
def os.fillFileStatFromSys#7(fs_0, fs_1, fs_3, fs_4, fs_2):
    if call os.fillFileStatFromSys#6(fs_0, fs_1, fs_3, fs_2, fs_4); else call os.fillFileStatFromSys#9(fs_0, fs_1, fs_3, fs_2, fs_4); endif;
def os.fillFileStatFromSys#8(fs_0, fs_1, fs_3, fs_4, fs_2):
    call os.fillFileStatFromSys#1(fs_0, fs_1, fs_3, fs_4, fs_2);
def os.fillFileStatFromSys#9(fs_0, fs_1, fs_3, fs_4, fs_2):
    if call os.fillFileStatFromSys#8(fs_0, fs_1, fs_3, fs_2, fs_4); else call os.fillFileStatFromSys#11(fs_0, fs_1, fs_3, fs_2, fs_4); endif;
def os.fillFileStatFromSys#10(fs_0, fs_1, fs_3, fs_4, fs_2):
    call os.fillFileStatFromSys#1(fs_0, fs_1, fs_3, fs_4, fs_2);
def os.fillFileStatFromSys#11(fs_0, fs_1, fs_3, fs_4, fs_2):
    if call os.fillFileStatFromSys#10(fs_0, fs_1, fs_3, fs_2, fs_4); else call os.fillFileStatFromSys#12(fs_0, fs_1, fs_3, fs_2, fs_4); endif;
def os.fillFileStatFromSys#12(fs_0, fs_1, fs_3, fs_4, fs_2):
    if call os.fillFileStatFromSys#1(fs_0, fs_1, fs_3, fs_2, fs_4); else call os.fillFileStatFromSys#14(fs_0, fs_1, fs_3, fs_2, fs_4); endif;
def os.fillFileStatFromSys#13(fs_0, fs_1, fs_3, fs_4, fs_2):
    call os.fillFileStatFromSys#1(fs_0, fs_1, fs_3, fs_4, fs_2);
def os.fillFileStatFromSys#14(fs_0, fs_1, fs_3, fs_4, fs_2):
    if call os.fillFileStatFromSys#13(fs_0, fs_1, fs_3, fs_2, fs_4); else call os.fillFileStatFromSys#1(fs_0, fs_1, fs_3, fs_2, fs_4); endif;
def os.fillFileStatFromSys#15(fs_0, fs_1, fs_3, fs_2, fs_4):
    call os.fillFileStatFromSys#16(fs_0, fs_1, fs_3, fs_4, fs_2);
def os.fillFileStatFromSys#16(fs_0, fs_1, fs_3, fs_4, fs_2):
    if call os.fillFileStatFromSys#17(fs_0, fs_1, fs_3, fs_2, fs_4); else call os.fillFileStatFromSys#18(fs_0, fs_1, fs_3, fs_2, fs_4); endif;
def os.fillFileStatFromSys#17(fs_0, fs_1, fs_3, fs_4, fs_2):
    call os.fillFileStatFromSys#18(fs_0, fs_1, fs_3, fs_4, fs_2);
def os.fillFileStatFromSys#18(fs_0, fs_1, fs_3, fs_4, fs_2):
    if call os.fillFileStatFromSys#19(fs_0, fs_1, fs_3, fs_2, fs_4); else endif;
def os.fillFileStatFromSys#19(fs_0, fs_1, fs_3, fs_4, fs_2):
    tau;
