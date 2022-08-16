
build/hello:     file format elf32-littleriscv


Disassembly of section .text:

00001000 <_start>:
    1000:	00001137          	lui	sp,0x1
    1004:	00001097          	auipc	ra,0x1
    1008:	8bc080e7          	jalr	-1860(ra) # 18c0 <main>

0000100c <loop>:
    100c:	0000006f          	j	100c <loop>

00001010 <enable_interrupt>:
    1010:	00000297          	auipc	t0,0x0
    1014:	02828293          	addi	t0,t0,40 # 1038 <__trap_entry>
    1018:	30529373          	csrrw	t1,mtvec,t0
    101c:	000022b7          	lui	t0,0x2
    1020:	88828293          	addi	t0,t0,-1912 # 1888 <trap_handler+0x60>
    1024:	30029373          	csrrw	t1,mstatus,t0
    1028:	00008067          	ret

0000102c <get_epc>:
    102c:	34102573          	csrr	a0,mepc
    1030:	00008067          	ret

00001034 <tran_handler>:
    1034:	00008067          	ret

00001038 <__trap_entry>:
    1038:	34011073          	csrw	mscratch,sp
    103c:	f8010113          	addi	sp,sp,-128 # f80 <_start-0x80>
    1040:	00112223          	sw	ra,4(sp)
    1044:	00312623          	sw	gp,12(sp)
    1048:	00412823          	sw	tp,16(sp)
    104c:	00512a23          	sw	t0,20(sp)
    1050:	00612c23          	sw	t1,24(sp)
    1054:	00712e23          	sw	t2,28(sp)
    1058:	02412023          	sw	tp,32(sp)
    105c:	02912223          	sw	s1,36(sp)
    1060:	02a12423          	sw	a0,40(sp)
    1064:	02b12623          	sw	a1,44(sp)
    1068:	02c12823          	sw	a2,48(sp)
    106c:	02d12a23          	sw	a3,52(sp)
    1070:	02e12c23          	sw	a4,56(sp)
    1074:	02f12e23          	sw	a5,60(sp)
    1078:	05012023          	sw	a6,64(sp)
    107c:	05112223          	sw	a7,68(sp)
    1080:	05212423          	sw	s2,72(sp)
    1084:	05312623          	sw	s3,76(sp)
    1088:	05412823          	sw	s4,80(sp)
    108c:	05512a23          	sw	s5,84(sp)
    1090:	05612c23          	sw	s6,88(sp)
    1094:	05712e23          	sw	s7,92(sp)
    1098:	07812023          	sw	s8,96(sp)
    109c:	07912223          	sw	s9,100(sp)
    10a0:	07a12423          	sw	s10,104(sp)
    10a4:	07b12623          	sw	s11,108(sp)
    10a8:	07c12823          	sw	t3,112(sp)
    10ac:	07d12a23          	sw	t4,116(sp)
    10b0:	07e12c23          	sw	t5,120(sp)
    10b4:	07f12e23          	sw	t6,124(sp)
    10b8:	34102573          	csrr	a0,mepc
    10bc:	342025f3          	csrr	a1,mcause
    10c0:	00000097          	auipc	ra,0x0
    10c4:	768080e7          	jalr	1896(ra) # 1828 <trap_handler>
    10c8:	00412083          	lw	ra,4(sp)
    10cc:	00c12183          	lw	gp,12(sp)
    10d0:	01012203          	lw	tp,16(sp)
    10d4:	01412283          	lw	t0,20(sp)
    10d8:	01812303          	lw	t1,24(sp)
    10dc:	01c12383          	lw	t2,28(sp)
    10e0:	02012203          	lw	tp,32(sp)
    10e4:	02412483          	lw	s1,36(sp)
    10e8:	02812503          	lw	a0,40(sp)
    10ec:	02c12583          	lw	a1,44(sp)
    10f0:	03012603          	lw	a2,48(sp)
    10f4:	03412683          	lw	a3,52(sp)
    10f8:	03812703          	lw	a4,56(sp)
    10fc:	03c12783          	lw	a5,60(sp)
    1100:	04012803          	lw	a6,64(sp)
    1104:	04412883          	lw	a7,68(sp)
    1108:	04812903          	lw	s2,72(sp)
    110c:	04c12983          	lw	s3,76(sp)
    1110:	05012a03          	lw	s4,80(sp)
    1114:	05412a83          	lw	s5,84(sp)
    1118:	05812b03          	lw	s6,88(sp)
    111c:	05c12b83          	lw	s7,92(sp)
    1120:	06012c03          	lw	s8,96(sp)
    1124:	06412c83          	lw	s9,100(sp)
    1128:	06812d03          	lw	s10,104(sp)
    112c:	06c12d83          	lw	s11,108(sp)
    1130:	07012e03          	lw	t3,112(sp)
    1134:	07412e83          	lw	t4,116(sp)
    1138:	07812f03          	lw	t5,120(sp)
    113c:	07c12f83          	lw	t6,124(sp)
    1140:	34002173          	csrr	sp,mscratch
    1144:	30200073          	mret

00001148 <copy_line>:
    1148:	fe010113          	addi	sp,sp,-32
    114c:	00112e23          	sw	ra,28(sp)
    1150:	00812c23          	sw	s0,24(sp)
    1154:	02010413          	addi	s0,sp,32
    1158:	fea42a23          	sw	a0,-12(s0)
    115c:	feb42823          	sw	a1,-16(s0)
    1160:	ff442583          	lw	a1,-12(s0)
    1164:	00659513          	slli	a0,a1,0x6
    1168:	00459593          	slli	a1,a1,0x4
    116c:	00b50533          	add	a0,a0,a1
    1170:	200005b7          	lui	a1,0x20000
    1174:	00b50533          	add	a0,a0,a1
    1178:	fea42623          	sw	a0,-20(s0)
    117c:	ff042603          	lw	a2,-16(s0)
    1180:	00661513          	slli	a0,a2,0x6
    1184:	00461613          	slli	a2,a2,0x4
    1188:	00c50533          	add	a0,a0,a2
    118c:	00b50533          	add	a0,a0,a1
    1190:	fea42423          	sw	a0,-24(s0)
    1194:	00000513          	li	a0,0
    1198:	fea42223          	sw	a0,-28(s0)
    119c:	0040006f          	j	11a0 <copy_line+0x58>
    11a0:	fe442583          	lw	a1,-28(s0)
    11a4:	01300513          	li	a0,19
    11a8:	02b54e63          	blt	a0,a1,11e4 <copy_line+0x9c>
    11ac:	0040006f          	j	11b0 <copy_line+0x68>
    11b0:	fe842503          	lw	a0,-24(s0)
    11b4:	fe442583          	lw	a1,-28(s0)
    11b8:	00259613          	slli	a2,a1,0x2
    11bc:	00c50533          	add	a0,a0,a2
    11c0:	00052503          	lw	a0,0(a0)
    11c4:	fec42583          	lw	a1,-20(s0)
    11c8:	00c585b3          	add	a1,a1,a2
    11cc:	00a5a023          	sw	a0,0(a1) # 20000000 <fast+0x1fffdf04>
    11d0:	0040006f          	j	11d4 <copy_line+0x8c>
    11d4:	fe442503          	lw	a0,-28(s0)
    11d8:	00150513          	addi	a0,a0,1
    11dc:	fea42223          	sw	a0,-28(s0)
    11e0:	fc1ff06f          	j	11a0 <copy_line+0x58>
    11e4:	01812403          	lw	s0,24(sp)
    11e8:	01c12083          	lw	ra,28(sp)
    11ec:	02010113          	addi	sp,sp,32
    11f0:	00008067          	ret

000011f4 <write_char>:
    11f4:	fe010113          	addi	sp,sp,-32
    11f8:	00112e23          	sw	ra,28(sp)
    11fc:	00812c23          	sw	s0,24(sp)
    1200:	02010413          	addi	s0,sp,32
    1204:	fea42a23          	sw	a0,-12(s0)
    1208:	feb42823          	sw	a1,-16(s0)
    120c:	fec407a3          	sb	a2,-17(s0)
    1210:	fef40503          	lb	a0,-17(s0)
    1214:	ff442603          	lw	a2,-12(s0)
    1218:	00661593          	slli	a1,a2,0x6
    121c:	00461613          	slli	a2,a2,0x4
    1220:	00c585b3          	add	a1,a1,a2
    1224:	ff042603          	lw	a2,-16(s0)
    1228:	00c585b3          	add	a1,a1,a2
    122c:	20000637          	lui	a2,0x20000
    1230:	00c585b3          	add	a1,a1,a2
    1234:	00a58023          	sb	a0,0(a1)
    1238:	01812403          	lw	s0,24(sp)
    123c:	01c12083          	lw	ra,28(sp)
    1240:	02010113          	addi	sp,sp,32
    1244:	00008067          	ret

00001248 <move_to>:
    1248:	ff010113          	addi	sp,sp,-16
    124c:	00112623          	sw	ra,12(sp)
    1250:	00812423          	sw	s0,8(sp)
    1254:	01010413          	addi	s0,sp,16
    1258:	fea42a23          	sw	a0,-12(s0)
    125c:	feb42823          	sw	a1,-16(s0)
    1260:	ff442503          	lw	a0,-12(s0)
    1264:	000025b7          	lui	a1,0x2
    1268:	0ea58c23          	sb	a0,248(a1) # 20f8 <_end>
    126c:	ff042503          	lw	a0,-16(s0)
    1270:	0f858593          	addi	a1,a1,248
    1274:	00a580a3          	sb	a0,1(a1)
    1278:	00812403          	lw	s0,8(sp)
    127c:	00c12083          	lw	ra,12(sp)
    1280:	01010113          	addi	sp,sp,16
    1284:	00008067          	ret

00001288 <new_line>:
    1288:	fe010113          	addi	sp,sp,-32
    128c:	00112e23          	sw	ra,28(sp)
    1290:	00812c23          	sw	s0,24(sp)
    1294:	02010413          	addi	s0,sp,32
    1298:	00002537          	lui	a0,0x2
    129c:	0f850613          	addi	a2,a0,248 # 20f8 <_end>
    12a0:	00000593          	li	a1,0
    12a4:	00b600a3          	sb	a1,1(a2) # 20000001 <fast+0x1fffdf05>
    12a8:	0f854503          	lbu	a0,248(a0)
    12ac:	01d00593          	li	a1,29
    12b0:	0ab51263          	bne	a0,a1,1354 <new_line+0xcc>
    12b4:	0040006f          	j	12b8 <new_line+0x30>
    12b8:	00000513          	li	a0,0
    12bc:	fea42a23          	sw	a0,-12(s0)
    12c0:	0040006f          	j	12c4 <new_line+0x3c>
    12c4:	ff442583          	lw	a1,-12(s0)
    12c8:	01c00513          	li	a0,28
    12cc:	02b54663          	blt	a0,a1,12f8 <new_line+0x70>
    12d0:	0040006f          	j	12d4 <new_line+0x4c>
    12d4:	ff442503          	lw	a0,-12(s0)
    12d8:	00150593          	addi	a1,a0,1
    12dc:	00000097          	auipc	ra,0x0
    12e0:	e6c080e7          	jalr	-404(ra) # 1148 <copy_line>
    12e4:	0040006f          	j	12e8 <new_line+0x60>
    12e8:	ff442503          	lw	a0,-12(s0)
    12ec:	00150513          	addi	a0,a0,1
    12f0:	fea42a23          	sw	a0,-12(s0)
    12f4:	fd1ff06f          	j	12c4 <new_line+0x3c>
    12f8:	20001537          	lui	a0,0x20001
    12fc:	91050513          	addi	a0,a0,-1776 # 20000910 <fast+0x1fffe814>
    1300:	fea42823          	sw	a0,-16(s0)
    1304:	00000513          	li	a0,0
    1308:	fea42623          	sw	a0,-20(s0)
    130c:	0040006f          	j	1310 <new_line+0x88>
    1310:	fec42583          	lw	a1,-20(s0)
    1314:	01300513          	li	a0,19
    1318:	02b54c63          	blt	a0,a1,1350 <new_line+0xc8>
    131c:	0040006f          	j	1320 <new_line+0x98>
    1320:	ff042503          	lw	a0,-16(s0)
    1324:	fec42583          	lw	a1,-20(s0)
    1328:	00259593          	slli	a1,a1,0x2
    132c:	00b505b3          	add	a1,a0,a1
    1330:	20202537          	lui	a0,0x20202
    1334:	02050513          	addi	a0,a0,32 # 20202020 <fast+0x201fff24>
    1338:	00a5a023          	sw	a0,0(a1)
    133c:	0040006f          	j	1340 <new_line+0xb8>
    1340:	fec42503          	lw	a0,-20(s0)
    1344:	00150513          	addi	a0,a0,1
    1348:	fea42623          	sw	a0,-20(s0)
    134c:	fc5ff06f          	j	1310 <new_line+0x88>
    1350:	0180006f          	j	1368 <new_line+0xe0>
    1354:	000025b7          	lui	a1,0x2
    1358:	0f858503          	lb	a0,248(a1) # 20f8 <_end>
    135c:	00150513          	addi	a0,a0,1
    1360:	0ea58c23          	sb	a0,248(a1)
    1364:	0040006f          	j	1368 <new_line+0xe0>
    1368:	01812403          	lw	s0,24(sp)
    136c:	01c12083          	lw	ra,28(sp)
    1370:	02010113          	addi	sp,sp,32
    1374:	00008067          	ret

00001378 <putch>:
    1378:	ff010113          	addi	sp,sp,-16
    137c:	00112623          	sw	ra,12(sp)
    1380:	00812423          	sw	s0,8(sp)
    1384:	01010413          	addi	s0,sp,16
    1388:	fea40ba3          	sb	a0,-9(s0)
    138c:	ff744503          	lbu	a0,-9(s0)
    1390:	00a00593          	li	a1,10
    1394:	00b51a63          	bne	a0,a1,13a8 <putch+0x30>
    1398:	0040006f          	j	139c <putch+0x24>
    139c:	00000097          	auipc	ra,0x0
    13a0:	eec080e7          	jalr	-276(ra) # 1288 <new_line>
    13a4:	0840006f          	j	1428 <putch+0xb0>
    13a8:	ff744503          	lbu	a0,-9(s0)
    13ac:	00d00593          	li	a1,13
    13b0:	00b51e63          	bne	a0,a1,13cc <putch+0x54>
    13b4:	0040006f          	j	13b8 <putch+0x40>
    13b8:	00002537          	lui	a0,0x2
    13bc:	0f850593          	addi	a1,a0,248 # 20f8 <_end>
    13c0:	00000513          	li	a0,0
    13c4:	00a580a3          	sb	a0,1(a1)
    13c8:	05c0006f          	j	1424 <putch+0xac>
    13cc:	00002537          	lui	a0,0x2
    13d0:	0f850513          	addi	a0,a0,248 # 20f8 <_end>
    13d4:	00154503          	lbu	a0,1(a0)
    13d8:	04f00593          	li	a1,79
    13dc:	00b51a63          	bne	a0,a1,13f0 <putch+0x78>
    13e0:	0040006f          	j	13e4 <putch+0x6c>
    13e4:	00000097          	auipc	ra,0x0
    13e8:	ea4080e7          	jalr	-348(ra) # 1288 <new_line>
    13ec:	0040006f          	j	13f0 <putch+0x78>
    13f0:	000025b7          	lui	a1,0x2
    13f4:	0f85c503          	lbu	a0,248(a1) # 20f8 <_end>
    13f8:	0f858593          	addi	a1,a1,248
    13fc:	feb42823          	sw	a1,-16(s0)
    1400:	0015c583          	lbu	a1,1(a1)
    1404:	ff744603          	lbu	a2,-9(s0)
    1408:	00000097          	auipc	ra,0x0
    140c:	dec080e7          	jalr	-532(ra) # 11f4 <write_char>
    1410:	ff042583          	lw	a1,-16(s0)
    1414:	00158503          	lb	a0,1(a1)
    1418:	00150513          	addi	a0,a0,1
    141c:	00a580a3          	sb	a0,1(a1)
    1420:	0040006f          	j	1424 <putch+0xac>
    1424:	0040006f          	j	1428 <putch+0xb0>
    1428:	00812403          	lw	s0,8(sp)
    142c:	00c12083          	lw	ra,12(sp)
    1430:	01010113          	addi	sp,sp,16
    1434:	00008067          	ret

00001438 <clear_screen>:
    1438:	ff010113          	addi	sp,sp,-16
    143c:	00112623          	sw	ra,12(sp)
    1440:	00812423          	sw	s0,8(sp)
    1444:	01010413          	addi	s0,sp,16
    1448:	000025b7          	lui	a1,0x2
    144c:	00000513          	li	a0,0
    1450:	0ea58c23          	sb	a0,248(a1) # 20f8 <_end>
    1454:	0f858593          	addi	a1,a1,248
    1458:	00a580a3          	sb	a0,1(a1)
    145c:	200005b7          	lui	a1,0x20000
    1460:	feb42a23          	sw	a1,-12(s0)
    1464:	fea42823          	sw	a0,-16(s0)
    1468:	0040006f          	j	146c <clear_screen+0x34>
    146c:	ff042583          	lw	a1,-16(s0)
    1470:	25700513          	li	a0,599
    1474:	02b54c63          	blt	a0,a1,14ac <clear_screen+0x74>
    1478:	0040006f          	j	147c <clear_screen+0x44>
    147c:	ff442503          	lw	a0,-12(s0)
    1480:	ff042583          	lw	a1,-16(s0)
    1484:	00259593          	slli	a1,a1,0x2
    1488:	00b505b3          	add	a1,a0,a1
    148c:	20202537          	lui	a0,0x20202
    1490:	02050513          	addi	a0,a0,32 # 20202020 <fast+0x201fff24>
    1494:	00a5a023          	sw	a0,0(a1) # 20000000 <fast+0x1fffdf04>
    1498:	0040006f          	j	149c <clear_screen+0x64>
    149c:	ff042503          	lw	a0,-16(s0)
    14a0:	00150513          	addi	a0,a0,1
    14a4:	fea42823          	sw	a0,-16(s0)
    14a8:	fc5ff06f          	j	146c <clear_screen+0x34>
    14ac:	00812403          	lw	s0,8(sp)
    14b0:	00c12083          	lw	ra,12(sp)
    14b4:	01010113          	addi	sp,sp,16
    14b8:	00008067          	ret

000014bc <print_hex>:
    14bc:	fe010113          	addi	sp,sp,-32
    14c0:	00112e23          	sw	ra,28(sp)
    14c4:	00812c23          	sw	s0,24(sp)
    14c8:	02010413          	addi	s0,sp,32
    14cc:	fea42a23          	sw	a0,-12(s0)
    14d0:	03000513          	li	a0,48
    14d4:	00000097          	auipc	ra,0x0
    14d8:	ea4080e7          	jalr	-348(ra) # 1378 <putch>
    14dc:	07800513          	li	a0,120
    14e0:	00000097          	auipc	ra,0x0
    14e4:	e98080e7          	jalr	-360(ra) # 1378 <putch>
    14e8:	00700513          	li	a0,7
    14ec:	fea42823          	sw	a0,-16(s0)
    14f0:	0040006f          	j	14f4 <print_hex+0x38>
    14f4:	ff042503          	lw	a0,-16(s0)
    14f8:	00000593          	li	a1,0
    14fc:	06b54a63          	blt	a0,a1,1570 <print_hex+0xb4>
    1500:	0040006f          	j	1504 <print_hex+0x48>
    1504:	ff442503          	lw	a0,-12(s0)
    1508:	ff042583          	lw	a1,-16(s0)
    150c:	00259593          	slli	a1,a1,0x2
    1510:	00b55533          	srl	a0,a0,a1
    1514:	00f57513          	andi	a0,a0,15
    1518:	fea42623          	sw	a0,-20(s0)
    151c:	fec42583          	lw	a1,-20(s0)
    1520:	00900513          	li	a0,9
    1524:	02b56063          	bltu	a0,a1,1544 <print_hex+0x88>
    1528:	0040006f          	j	152c <print_hex+0x70>
    152c:	fec42503          	lw	a0,-20(s0)
    1530:	03050513          	addi	a0,a0,48
    1534:	0ff57513          	andi	a0,a0,255
    1538:	00000097          	auipc	ra,0x0
    153c:	e40080e7          	jalr	-448(ra) # 1378 <putch>
    1540:	01c0006f          	j	155c <print_hex+0xa0>
    1544:	fec42503          	lw	a0,-20(s0)
    1548:	03750513          	addi	a0,a0,55
    154c:	0ff57513          	andi	a0,a0,255
    1550:	00000097          	auipc	ra,0x0
    1554:	e28080e7          	jalr	-472(ra) # 1378 <putch>
    1558:	0040006f          	j	155c <print_hex+0xa0>
    155c:	0040006f          	j	1560 <print_hex+0xa4>
    1560:	ff042503          	lw	a0,-16(s0)
    1564:	fff50513          	addi	a0,a0,-1
    1568:	fea42823          	sw	a0,-16(s0)
    156c:	f89ff06f          	j	14f4 <print_hex+0x38>
    1570:	01812403          	lw	s0,24(sp)
    1574:	01c12083          	lw	ra,28(sp)
    1578:	02010113          	addi	sp,sp,32
    157c:	00008067          	ret

00001580 <putstr>:
    1580:	ff010113          	addi	sp,sp,-16
    1584:	00112623          	sw	ra,12(sp)
    1588:	00812423          	sw	s0,8(sp)
    158c:	01010413          	addi	s0,sp,16
    1590:	fea42a23          	sw	a0,-12(s0)
    1594:	0040006f          	j	1598 <putstr+0x18>
    1598:	ff442503          	lw	a0,-12(s0)
    159c:	00054503          	lbu	a0,0(a0)
    15a0:	00000593          	li	a1,0
    15a4:	02b50263          	beq	a0,a1,15c8 <putstr+0x48>
    15a8:	0040006f          	j	15ac <putstr+0x2c>
    15ac:	ff442503          	lw	a0,-12(s0)
    15b0:	00150593          	addi	a1,a0,1
    15b4:	feb42a23          	sw	a1,-12(s0)
    15b8:	00054503          	lbu	a0,0(a0)
    15bc:	00000097          	auipc	ra,0x0
    15c0:	dbc080e7          	jalr	-580(ra) # 1378 <putch>
    15c4:	fd5ff06f          	j	1598 <putstr+0x18>
    15c8:	00812403          	lw	s0,8(sp)
    15cc:	00c12083          	lw	ra,12(sp)
    15d0:	01010113          	addi	sp,sp,16
    15d4:	00008067          	ret

000015d8 <print_timer>:
    15d8:	ff010113          	addi	sp,sp,-16
    15dc:	00112623          	sw	ra,12(sp)
    15e0:	00812423          	sw	s0,8(sp)
    15e4:	01010413          	addi	s0,sp,16
    15e8:	00002537          	lui	a0,0x2
    15ec:	01550513          	addi	a0,a0,21 # 2015 <main+0x755>
    15f0:	00000097          	auipc	ra,0x0
    15f4:	f90080e7          	jalr	-112(ra) # 1580 <putstr>
    15f8:	80000537          	lui	a0,0x80000
    15fc:	fea42a23          	sw	a0,-12(s0)
    1600:	00452503          	lw	a0,4(a0) # 80000004 <fast+0x7fffdf08>
    1604:	00000097          	auipc	ra,0x0
    1608:	eb8080e7          	jalr	-328(ra) # 14bc <print_hex>
    160c:	00002537          	lui	a0,0x2
    1610:	06c50513          	addi	a0,a0,108 # 206c <main+0x7ac>
    1614:	00000097          	auipc	ra,0x0
    1618:	f6c080e7          	jalr	-148(ra) # 1580 <putstr>
    161c:	ff442503          	lw	a0,-12(s0)
    1620:	00852503          	lw	a0,8(a0)
    1624:	00000097          	auipc	ra,0x0
    1628:	e98080e7          	jalr	-360(ra) # 14bc <print_hex>
    162c:	00a00513          	li	a0,10
    1630:	00000097          	auipc	ra,0x0
    1634:	d48080e7          	jalr	-696(ra) # 1378 <putch>
    1638:	00812403          	lw	s0,8(sp)
    163c:	00c12083          	lw	ra,12(sp)
    1640:	01010113          	addi	sp,sp,16
    1644:	00008067          	ret

00001648 <print_uart>:
    1648:	ff010113          	addi	sp,sp,-16
    164c:	00112623          	sw	ra,12(sp)
    1650:	00812423          	sw	s0,8(sp)
    1654:	01010413          	addi	s0,sp,16
    1658:	00002537          	lui	a0,0x2
    165c:	03350513          	addi	a0,a0,51 # 2033 <main+0x773>
    1660:	00000097          	auipc	ra,0x0
    1664:	f20080e7          	jalr	-224(ra) # 1580 <putstr>
    1668:	40000537          	lui	a0,0x40000
    166c:	00452503          	lw	a0,4(a0) # 40000004 <fast+0x3fffdf08>
    1670:	00000097          	auipc	ra,0x0
    1674:	e4c080e7          	jalr	-436(ra) # 14bc <print_hex>
    1678:	00a00513          	li	a0,10
    167c:	00000097          	auipc	ra,0x0
    1680:	cfc080e7          	jalr	-772(ra) # 1378 <putch>
    1684:	00812403          	lw	s0,8(sp)
    1688:	00c12083          	lw	ra,12(sp)
    168c:	01010113          	addi	sp,sp,16
    1690:	00008067          	ret

00001694 <handle_timer>:
    1694:	ff010113          	addi	sp,sp,-16
    1698:	00112623          	sw	ra,12(sp)
    169c:	00812423          	sw	s0,8(sp)
    16a0:	01010413          	addi	s0,sp,16
    16a4:	00002537          	lui	a0,0x2
    16a8:	07950513          	addi	a0,a0,121 # 2079 <main+0x7b9>
    16ac:	00000097          	auipc	ra,0x0
    16b0:	ed4080e7          	jalr	-300(ra) # 1580 <putstr>
    16b4:	00002637          	lui	a2,0x2
    16b8:	fec42823          	sw	a2,-16(s0)
    16bc:	0f462503          	lw	a0,244(a2) # 20f4 <hc>
    16c0:	00150593          	addi	a1,a0,1
    16c4:	0eb62a23          	sw	a1,244(a2)
    16c8:	00000097          	auipc	ra,0x0
    16cc:	df4080e7          	jalr	-524(ra) # 14bc <print_hex>
    16d0:	00a00513          	li	a0,10
    16d4:	00000097          	auipc	ra,0x0
    16d8:	ca4080e7          	jalr	-860(ra) # 1378 <putch>
    16dc:	ff042503          	lw	a0,-16(s0)
    16e0:	0f452583          	lw	a1,244(a0)
    16e4:	0105f593          	andi	a1,a1,16
    16e8:	0045d593          	srli	a1,a1,0x4
    16ec:	feb42a23          	sw	a1,-12(s0)
    16f0:	0f452503          	lw	a0,244(a0)
    16f4:	04000593          	li	a1,64
    16f8:	02b51863          	bne	a0,a1,1728 <handle_timer+0x94>
    16fc:	0040006f          	j	1700 <handle_timer+0x6c>
    1700:	00002537          	lui	a0,0x2
    1704:	0a450513          	addi	a0,a0,164 # 20a4 <main+0x7e4>
    1708:	00000097          	auipc	ra,0x0
    170c:	e78080e7          	jalr	-392(ra) # 1580 <putstr>
    1710:	800005b7          	lui	a1,0x80000
    1714:	00000513          	li	a0,0
    1718:	00a5a423          	sw	a0,8(a1) # 80000008 <fast+0x7fffdf0c>
    171c:	00000097          	auipc	ra,0x0
    1720:	ebc080e7          	jalr	-324(ra) # 15d8 <print_timer>
    1724:	07c0006f          	j	17a0 <handle_timer+0x10c>
    1728:	00002537          	lui	a0,0x2
    172c:	0fc52503          	lw	a0,252(a0) # 20fc <fast>
    1730:	ff442583          	lw	a1,-12(s0)
    1734:	06b50663          	beq	a0,a1,17a0 <handle_timer+0x10c>
    1738:	0040006f          	j	173c <handle_timer+0xa8>
    173c:	00002537          	lui	a0,0x2
    1740:	04550513          	addi	a0,a0,69 # 2045 <main+0x785>
    1744:	00000097          	auipc	ra,0x0
    1748:	e3c080e7          	jalr	-452(ra) # 1580 <putstr>
    174c:	00002537          	lui	a0,0x2
    1750:	0fc52503          	lw	a0,252(a0) # 20fc <fast>
    1754:	00000593          	li	a1,0
    1758:	00b51e63          	bne	a0,a1,1774 <handle_timer+0xe0>
    175c:	0040006f          	j	1760 <handle_timer+0xcc>
    1760:	017d8537          	lui	a0,0x17d8
    1764:	84050513          	addi	a0,a0,-1984 # 17d7840 <fast+0x17d5744>
    1768:	800005b7          	lui	a1,0x80000
    176c:	00a5a223          	sw	a0,4(a1) # 80000004 <fast+0x7fffdf08>
    1770:	0180006f          	j	1788 <handle_timer+0xf4>
    1774:	05f5e537          	lui	a0,0x5f5e
    1778:	10050513          	addi	a0,a0,256 # 5f5e100 <fast+0x5f5c004>
    177c:	800005b7          	lui	a1,0x80000
    1780:	00a5a223          	sw	a0,4(a1) # 80000004 <fast+0x7fffdf08>
    1784:	0040006f          	j	1788 <handle_timer+0xf4>
    1788:	ff442503          	lw	a0,-12(s0)
    178c:	000025b7          	lui	a1,0x2
    1790:	0ea5ae23          	sw	a0,252(a1) # 20fc <fast>
    1794:	00000097          	auipc	ra,0x0
    1798:	e44080e7          	jalr	-444(ra) # 15d8 <print_timer>
    179c:	0040006f          	j	17a0 <handle_timer+0x10c>
    17a0:	00812403          	lw	s0,8(sp)
    17a4:	00c12083          	lw	ra,12(sp)
    17a8:	01010113          	addi	sp,sp,16
    17ac:	00008067          	ret

000017b0 <handle_uart>:
    17b0:	ff010113          	addi	sp,sp,-16
    17b4:	00112623          	sw	ra,12(sp)
    17b8:	00812423          	sw	s0,8(sp)
    17bc:	01010413          	addi	s0,sp,16
    17c0:	400005b7          	lui	a1,0x40000
    17c4:	00c5a503          	lw	a0,12(a1) # 4000000c <fast+0x3fffdf10>
    17c8:	fea42a23          	sw	a0,-12(s0)
    17cc:	ff442503          	lw	a0,-12(s0)
    17d0:	00a5a823          	sw	a0,16(a1)
    17d4:	00002537          	lui	a0,0x2
    17d8:	0b450513          	addi	a0,a0,180 # 20b4 <main+0x7f4>
    17dc:	00000097          	auipc	ra,0x0
    17e0:	da4080e7          	jalr	-604(ra) # 1580 <putstr>
    17e4:	ff442503          	lw	a0,-12(s0)
    17e8:	00000097          	auipc	ra,0x0
    17ec:	cd4080e7          	jalr	-812(ra) # 14bc <print_hex>
    17f0:	00002537          	lui	a0,0x2
    17f4:	09050513          	addi	a0,a0,144 # 2090 <main+0x7d0>
    17f8:	00000097          	auipc	ra,0x0
    17fc:	d88080e7          	jalr	-632(ra) # 1580 <putstr>
    1800:	ff444503          	lbu	a0,-12(s0)
    1804:	00000097          	auipc	ra,0x0
    1808:	b74080e7          	jalr	-1164(ra) # 1378 <putch>
    180c:	00a00513          	li	a0,10
    1810:	00000097          	auipc	ra,0x0
    1814:	b68080e7          	jalr	-1176(ra) # 1378 <putch>
    1818:	00812403          	lw	s0,8(sp)
    181c:	00c12083          	lw	ra,12(sp)
    1820:	01010113          	addi	sp,sp,16
    1824:	00008067          	ret

00001828 <trap_handler>:
    1828:	ff010113          	addi	sp,sp,-16
    182c:	00112623          	sw	ra,12(sp)
    1830:	00812423          	sw	s0,8(sp)
    1834:	01010413          	addi	s0,sp,16
    1838:	fea42a23          	sw	a0,-12(s0)
    183c:	feb42823          	sw	a1,-16(s0)
    1840:	00002537          	lui	a0,0x2
    1844:	0c550513          	addi	a0,a0,197 # 20c5 <main+0x805>
    1848:	00000097          	auipc	ra,0x0
    184c:	d38080e7          	jalr	-712(ra) # 1580 <putstr>
    1850:	ff442503          	lw	a0,-12(s0)
    1854:	00000097          	auipc	ra,0x0
    1858:	c68080e7          	jalr	-920(ra) # 14bc <print_hex>
    185c:	00002537          	lui	a0,0x2
    1860:	0d750513          	addi	a0,a0,215 # 20d7 <main+0x817>
    1864:	00000097          	auipc	ra,0x0
    1868:	d1c080e7          	jalr	-740(ra) # 1580 <putstr>
    186c:	ff042503          	lw	a0,-16(s0)
    1870:	00000097          	auipc	ra,0x0
    1874:	c4c080e7          	jalr	-948(ra) # 14bc <print_hex>
    1878:	00a00513          	li	a0,10
    187c:	00000097          	auipc	ra,0x0
    1880:	afc080e7          	jalr	-1284(ra) # 1378 <putch>
    1884:	ff042503          	lw	a0,-16(s0)
    1888:	800005b7          	lui	a1,0x80000
    188c:	00b58593          	addi	a1,a1,11 # 8000000b <fast+0x7fffdf0f>
    1890:	00b51a63          	bne	a0,a1,18a4 <trap_handler+0x7c>
    1894:	0040006f          	j	1898 <trap_handler+0x70>
    1898:	00000097          	auipc	ra,0x0
    189c:	f18080e7          	jalr	-232(ra) # 17b0 <handle_uart>
    18a0:	0100006f          	j	18b0 <trap_handler+0x88>
    18a4:	00000097          	auipc	ra,0x0
    18a8:	df0080e7          	jalr	-528(ra) # 1694 <handle_timer>
    18ac:	0040006f          	j	18b0 <trap_handler+0x88>
    18b0:	00812403          	lw	s0,8(sp)
    18b4:	00c12083          	lw	ra,12(sp)
    18b8:	01010113          	addi	sp,sp,16
    18bc:	00008067          	ret

000018c0 <main>:
    18c0:	fe010113          	addi	sp,sp,-32
    18c4:	00112e23          	sw	ra,28(sp)
    18c8:	00812c23          	sw	s0,24(sp)
    18cc:	02010413          	addi	s0,sp,32
    18d0:	00000513          	li	a0,0
    18d4:	fea42623          	sw	a0,-20(s0)
    18d8:	fea42a23          	sw	a0,-12(s0)
    18dc:	00000097          	auipc	ra,0x0
    18e0:	b5c080e7          	jalr	-1188(ra) # 1438 <clear_screen>
    18e4:	fec42503          	lw	a0,-20(s0)
    18e8:	000025b7          	lui	a1,0x2
    18ec:	0ea5aa23          	sw	a0,244(a1) # 20f4 <hc>
    18f0:	800005b7          	lui	a1,0x80000
    18f4:	00100513          	li	a0,1
    18f8:	00a5a423          	sw	a0,8(a1) # 80000008 <fast+0x7fffdf0c>
    18fc:	00002537          	lui	a0,0x2
    1900:	00050513          	mv	a0,a0
    1904:	00000097          	auipc	ra,0x0
    1908:	c7c080e7          	jalr	-900(ra) # 1580 <putstr>
    190c:	08900513          	li	a0,137
    1910:	00000097          	auipc	ra,0x0
    1914:	a68080e7          	jalr	-1432(ra) # 1378 <putch>
    1918:	00002537          	lui	a0,0x2
    191c:	0e250513          	addi	a0,a0,226 # 20e2 <main+0x822>
    1920:	00000097          	auipc	ra,0x0
    1924:	c60080e7          	jalr	-928(ra) # 1580 <putstr>
    1928:	00002537          	lui	a0,0x2
    192c:	05d50513          	addi	a0,a0,93 # 205d <main+0x79d>
    1930:	00000097          	auipc	ra,0x0
    1934:	c50080e7          	jalr	-944(ra) # 1580 <putstr>
    1938:	00002537          	lui	a0,0x2
    193c:	09850513          	addi	a0,a0,152 # 2098 <main+0x7d8>
    1940:	00000097          	auipc	ra,0x0
    1944:	c40080e7          	jalr	-960(ra) # 1580 <putstr>
    1948:	fffff097          	auipc	ra,0xfffff
    194c:	6e4080e7          	jalr	1764(ra) # 102c <get_epc>
    1950:	00000097          	auipc	ra,0x0
    1954:	b6c080e7          	jalr	-1172(ra) # 14bc <print_hex>
    1958:	00a00513          	li	a0,10
    195c:	00000097          	auipc	ra,0x0
    1960:	a1c080e7          	jalr	-1508(ra) # 1378 <putch>
    1964:	00000097          	auipc	ra,0x0
    1968:	c74080e7          	jalr	-908(ra) # 15d8 <print_timer>
    196c:	00000097          	auipc	ra,0x0
    1970:	cdc080e7          	jalr	-804(ra) # 1648 <print_uart>
    1974:	fec42503          	lw	a0,-20(s0)
    1978:	deadc5b7          	lui	a1,0xdeadc
    197c:	eef58593          	addi	a1,a1,-273 # deadbeef <fast+0xdead9df3>
    1980:	00b02223          	sw	a1,4(zero) # 4 <_start-0xffc>
    1984:	fea42823          	sw	a0,-16(s0)
    1988:	fffff097          	auipc	ra,0xfffff
    198c:	688080e7          	jalr	1672(ra) # 1010 <enable_interrupt>
    1990:	0040006f          	j	1994 <main+0xd4>
    1994:	0000006f          	j	1994 <main+0xd4>

Disassembly of section .data:

00002000 <hc-0xf4>:
    2000:	6159                	addi	sp,sp,400
    2002:	4374                	lw	a3,68(a4)
    2004:	5550                	lw	a2,44(a0)
    2006:	4420                	lw	s0,72(s0)
    2008:	6d65                	lui	s10,0x19
    200a:	7250206f          	j	4f2e <fast+0x2e32>
    200e:	6172676f          	jal	a4,28e24 <fast+0x26d28>
    2012:	206d                	jal	20bc <main+0x7fc>
    2014:	4800                	lw	s0,16(s0)
    2016:	7261                	lui	tp,0xffff8
    2018:	7764                	flw	fs1,108(a4)
    201a:	7261                	lui	tp,0xffff8
    201c:	2065                	jal	20c4 <main+0x804>
    201e:	6974                	flw	fa3,84(a0)
    2020:	656d                	lui	a0,0x1b
    2022:	2072                	fld	ft0,280(sp)
    2024:	6e756f63          	bltu	a0,t2,2722 <fast+0x626>
    2028:	2074                	fld	fa3,192(s0)
    202a:	696c                	flw	fa1,84(a0)
    202c:	696d                	lui	s2,0x1b
    202e:	2074                	fld	fa3,192(s0)
    2030:	203d                	jal	205e <main+0x79e>
    2032:	5500                	lw	s0,40(a0)
    2034:	5241                	li	tp,-16
    2036:	2054                	fld	fa3,128(s0)
    2038:	6142                	flw	ft2,16(sp)
    203a:	6475                	lui	s0,0x1d
    203c:	7220                	flw	fs0,96(a2)
    203e:	7461                	lui	s0,0xffff8
    2040:	2065                	jal	20e8 <main+0x828>
    2042:	203d                	jal	2070 <main+0x7b0>
    2044:	5300                	lw	s0,32(a4)
    2046:	63746977          	0x63746977
    204a:	2068                	fld	fa0,192(s0)
    204c:	6974                	flw	fa3,84(a0)
    204e:	656d                	lui	a0,0x1b
    2050:	2072                	fld	ft0,280(sp)
    2052:	7266                	flw	ft4,120(sp)
    2054:	7165                	addi	sp,sp,-400
    2056:	6575                	lui	a0,0x1d
    2058:	636e                	flw	ft6,216(sp)
    205a:	0a79                	addi	s4,s4,30
    205c:	4800                	lw	s0,16(s0)
    205e:	6c65                	lui	s8,0x19
    2060:	6f6c                	flw	fa1,92(a4)
    2062:	202c                	fld	fa1,64(s0)
    2064:	6c726f77          	0x6c726f77
    2068:	2164                	fld	fs1,192(a0)
    206a:	000a                	c.slli	zero,0x2
    206c:	202c                	fld	fa1,64(s0)
    206e:	6e65                	lui	t3,0x19
    2070:	6261                	lui	tp,0x18
    2072:	656c                	flw	fa1,76(a0)
    2074:	2064                	fld	fs1,192(s0)
    2076:	203d                	jal	20a4 <main+0x7e4>
    2078:	5400                	lw	s0,40(s0)
    207a:	6d69                	lui	s10,0x1a
    207c:	7265                	lui	tp,0xffff9
    207e:	7420                	flw	fs0,104(s0)
    2080:	6972                	flw	fs2,28(sp)
    2082:	72656767          	0x72656767
    2086:	7420                	flw	fs0,104(s0)
    2088:	6d69                	lui	s10,0x1a
    208a:	7365                	lui	t1,0xffff9
    208c:	3d20                	fld	fs0,120(a0)
    208e:	0020                	addi	s0,sp,8
    2090:	202c                	fld	fa1,64(s0)
    2092:	3d206863          	bltu	zero,s2,2462 <fast+0x366>
    2096:	0020                	addi	s0,sp,8
    2098:	614c                	flw	fa1,4(a0)
    209a:	45207473          	csrrci	s0,0x452,0
    209e:	4350                	lw	a2,4(a4)
    20a0:	3d20                	fld	fs0,120(a0)
    20a2:	0020                	addi	s0,sp,8
    20a4:	6944                	flw	fs1,20(a0)
    20a6:	6c626173          	csrrsi	sp,0x6c6,4
    20aa:	2065                	jal	2152 <fast+0x56>
    20ac:	6974                	flw	fa3,84(a0)
    20ae:	656d                	lui	a0,0x1b
    20b0:	2172                	fld	ft2,280(sp)
    20b2:	000a                	c.slli	zero,0x2
    20b4:	4155                	li	sp,21
    20b6:	5452                	lw	s0,52(sp)
    20b8:	5220                	lw	s0,96(a2)
    20ba:	6365                	lui	t1,0x19
    20bc:	2076                	fld	ft0,344(sp)
    20be:	6568                	flw	fa0,76(a0)
    20c0:	2078                	fld	fa4,192(s0)
    20c2:	203d                	jal	20f0 <main+0x830>
    20c4:	4900                	lw	s0,16(a0)
    20c6:	746e                	flw	fs0,248(sp)
    20c8:	7265                	lui	tp,0xffff9
    20ca:	7572                	flw	fa0,60(sp)
    20cc:	7470                	flw	fa2,108(s0)
    20ce:	2021                	jal	20d6 <main+0x816>
    20d0:	5045                	c.li	zero,-15
    20d2:	203d2043          	fmadd.s	ft0,fs10,ft3,ft4,rdn
    20d6:	2c00                	fld	fs0,24(s0)
    20d8:	4320                	lw	s0,64(a4)
    20da:	5541                	li	a0,-16
    20dc:	3d204553          	0x3d204553
    20e0:	0020                	addi	s0,sp,8
    20e2:	3032                	fld	ft0,296(sp)
    20e4:	3132                	fld	ft2,296(sp)
    20e6:	4820                	lw	s0,80(s0)
    20e8:	7261776f          	jal	a4,1980e <fast+0x17712>
    20ec:	2064                	fld	fs1,192(s0)
    20ee:	614c                	flw	fa1,4(a0)
    20f0:	0a75                	addi	s4,s4,29
	...

000020f4 <hc>:
    20f4:	0001                	nop
	...

Disassembly of section .sbss:

000020f8 <scr>:
    20f8:	0000                	unimp
	...

000020fc <fast>:
    20fc:	0000                	unimp
	...

Disassembly of section .comment:

00000000 <.comment>:
   0:	6e616c63          	bltu	sp,t1,6f8 <_start-0x908>
   4:	65762067          	0x65762067
   8:	7372                	flw	ft6,60(sp)
   a:	6f69                	lui	t5,0x1a
   c:	206e                	fld	ft0,216(sp)
   e:	3331                	jal	fffffd1a <fast+0xffffdc1e>
  10:	302e                	fld	ft0,232(sp)
  12:	312e                	fld	ft2,232(sp)
  14:	4c00                	lw	s0,24(s0)
  16:	6e69                	lui	t3,0x1a
  18:	3a72656b          	0x3a72656b
  1c:	4c20                	lw	s0,88(s0)
  1e:	444c                	lw	a1,12(s0)
  20:	3120                	fld	fs0,96(a0)
  22:	2e302e33          	0x2e302e33
  26:	0031                	c.nop	12
	...

Disassembly of section .riscv.attributes:

00000000 <.riscv.attributes>:
   0:	1b41                	addi	s6,s6,-16
   2:	0000                	unimp
   4:	7200                	flw	fs0,32(a2)
   6:	7369                	lui	t1,0xffffa
   8:	01007663          	bgeu	zero,a6,14 <_start-0xfec>
   c:	0011                	c.nop	4
   e:	0000                	unimp
  10:	1004                	addi	s1,sp,32
  12:	7205                	lui	tp,0xfffe1
  14:	3376                	fld	ft6,376(sp)
  16:	6932                	flw	fs2,12(sp)
  18:	7032                	flw	ft0,44(sp)
  1a:	0030                	addi	a2,sp,8
