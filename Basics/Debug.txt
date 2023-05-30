//Create an instance of SimpleClaculator
SimpleCalculator calc = new SimpleCalculator();
calc.add();
calc.sub();
calc.multiply();
calc.divide();
calc.paraAdd(5,5);

//Direct print on debug
System.debug('Simple Return Value: '+calc.paraSub(5,4));

//Store in a variable & print
Integer varSub;
varSub = calc.paraSub(5,4);
System.debug('Returned Value: '+varSub);
