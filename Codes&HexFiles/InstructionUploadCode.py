def compiler(instruction) :

    parts = instruction.split()

    instructions = [ 'NOP' ,   'CLAC' ,   'LDAC' ,     'STAC' ,     'INAC' ,     'DCAC' ,     'ADD256' ,  'SUB256' ,   'SUBL' ,     'SUBBE' ,     'DIV2' ,      'DIV16' ,     'MUL2' ,      'MUL4' ,     'MULL' ,     'ADDR1' ,    'ADDR3' ,   'ADDL' ,         'MVACL' ,    'MVACE' ,      'MVACR1' ,     'MVACR2' ,      'MVACR3' ,     'MVACR4' ,     'MVACAR' ,      'MVEAC' ,      'MVR1AC' ,       'MVR2AC' ,       'MVR3AC' ,       'MVR4AC'  ,       'JMPZ' ,   'JMPN'   ,   'END'  ]
    inscode = [ '00000000' , '00000001' , '00000010' , '00000011' , '00000100' , '00000101' , '00000110' , '00000111' , '00001000' , '00001001' , '00001010' , '00001011' , '00001100' ,    '00001101' ,'00001110' , '00001111' , '00010000' ,  '00010001' ,    '00010010' , '00010011' ,   '00010100'  ,   '00010101' ,    '00010110' ,   '00010111' ,   '00011000' ,   '00011001' ,    '00011010' ,   '00011011' ,     '00011100' ,     '00011101' ,     '00011110' ,    '00011111',  '00100000']

    opcode = inscode[instructions.index(parts[0])]
    return opcode

file = open ('CopyAssembly.txt' , 'r' )
hexfile = open ( 'hexfile.txt' , 'w' )
lines =file.readlines()
print(lines)
opcodes = []

for i in range (len (lines )) :
    opcodes.append(compiler(lines[i]))

for l in opcodes :
    print(l)
    y = str(hex(int(l,2)))
    hexfile.write(y[2:])
    hexfile.write("\n")