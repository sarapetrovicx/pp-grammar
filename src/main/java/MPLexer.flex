// import section

import java_cup.runtime.*;

%%
// declaration section
%class MPLexer

%cup

%line
%column

%eofval{
	return new Symbol( sym.EOF );
%eofval}

%{
   public int getLine()
   {
      return yyline;
   }
%}


//states
%state COMMENT
//macros
slovo = [a-zA-Z]
cifra = [0-9]

%%
// rules section
\(\*			{ yybegin( COMMENT ); }
<COMMENT>\*\)	{ yybegin( YYINITIAL ); }
<COMMENT>.		{ ; }

[\t\r\n ]		{ ; }

//operators
\+				{ return new Symbol( sym.PLUS ); }
\*				{ return new Symbol( sym.MUL );  }

//separators
;				{ return new Symbol( sym.SEMI );	}
,				{ return new Symbol( sym.COMMA );	}
\.				{ return new Symbol( sym.DOT ); }
:				{ return new Symbol( sym.DOTDOT ); }
==				{ return new Symbol( sym.ASSIGN ); }
\(				{ return new Symbol( sym.LEFTPAR ); }
\)				{ return new Symbol( sym.RIGHTPAR ); }
=>			   { return new Symbol( sym.ARROW ); }
\[  		   { return new Symbol( sym.LEFTBRA ); }
\]		      { return new Symbol( sym.RIGHTBRA ); }
\<			   { return new Symbol( sym.BEGIN );	}
\>     		{ return new Symbol( sym.END );	}
\~           { return new Symbol( sym.TILDE );	}

//keywords
"main"		{ return new Symbol( sym.MAIN );	}	
"var"			{ return new Symbol( sym.VAR );	}
"int"		   { return new Symbol( sym.INT);	}
"char"		{ return new Symbol( sym.CHAR );	}
"bool"		{ return new Symbol( sym.BOOL );	}
"input"		{ return new Symbol( sym.INPUT );	}
"output"		{ return new Symbol( sym.OUTPUT );	}
"if"			{ return new Symbol( sym.IF );	}
"do"		   { return new Symbol( sym.DO );	}
"else"		{ return new Symbol( sym.ELSE );	}
"while"     { return new Symbol( sym.WHILE );	}


//id-s
{slovo}({slovo}|{cifra})*	{ return new Symbol( sym.ID, yyline); }

//constants
\'[^]\'			{ return new Symbol( sym.CONST, yyline, new Character( yytext().charAt(1) ) ); }
{cifra}+		{ return new Symbol( sym.CONST, yyline, new Integer( yytext() ) ); }



//error symbol
.		{ System.out.println( "ERROR: " + yytext() ); }

