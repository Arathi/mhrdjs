grammar Mhdl;

mhdl
    : inputsBlock outputsBlock partsBlock wiresBlock EOF
    ;

inputsBlock
    : INPUTS CL inputPorts SC EOL
    ;

outputsBlock
    : OUTPUTS CL outputPorts SC EOL
    ;

partsBlock
    : PARTS CL parts SC EOL 
    ;

wiresBlock
    : WIRES CL wires SC EOL?
    ;

inputPorts
    : portDeclareML (CM portDeclareML)*
    ;

outputPorts
    : portDeclareML (CM portDeclareML)*
    ;

portDeclareML
    : EOL? portDeclare EOL?
    ;

portDeclare
    : pinDeclare
    | busDeclare
    ;

pinDeclare
    : pinName
    ;

busDeclare
    : busName LB upperIndex CL lowerIndex RB
    ;

parts
    : partDeclareML (CM partDeclareML)*
    ;

partDeclareML
    : EOL? partDeclare EOL?
    ;

partDeclare
    : partName partType
    ;

wires
    : wireDeclareML (CM wireDeclareML)*
    ;

wireDeclareML
    : EOL? wireDeclare EOL?
    ;

wireDeclare
    : srcPort TO sinkPort
    ;

srcPort
    : port
    ;

sinkPort
    : port
    ;

port
    : pin
    | bus
    ;

pin
    : pinName
    | busName LB pinIndex RB
    | partName DOT pinName
    | partName DOT busName LB pinIndex RB
    ;

bus
    : busName LB upperIndex CL lowerIndex RB
    ;

INPUTS: 'Inputs';
OUTPUTS: 'Outputs';
PARTS: 'Parts';
WIRES: 'Wires';

CM: ',';
SC: ';';
LB: '[';
RB: ']';
CL: ':';
DOT: '.';
TO: '->';

pinName: ID;
busName: ID;
partName: ID;
partType: MODULE_ID;
upperIndex: NUMBER;
lowerIndex: NUMBER;
pinIndex: NUMBER;

ID: [a-z][_0-9A-Za-z]*;
MODULE_ID: [A-Z][_0-9A-Z]*;
NUMBER: [0-9]+;
EOL: [\r\n]+;
WS: [ \t] -> skip;
