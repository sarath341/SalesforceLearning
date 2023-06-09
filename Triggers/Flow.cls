//Similar method in Flow example
Contact con = new Contact();//Variable Con
con.FirstName = 'Vinay';//Screen Element - Screen Input Variable and Bind it with field
con.LastName = 'KS';//Screen Element

try{
    insert con;//Element - Create Record
}
(catch DMLException ex){//Fault Element
    System.debug(ex.getMessage());//Fault Message
}
