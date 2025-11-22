validInput( val, int min, int max, String type) {
  if (type == "email") {
    if(!val.contains('@gmail.com') ){
      return 'unvalaid email';
    }
    else if(val.length<min){
      return 'the email should not be less than $min charecters';
    }
  } else if (type == "password") {
     if(val.length<min){
      return 'the password should not be less than $min charecters';
    }
  }
}
