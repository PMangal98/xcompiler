%{ /* C Declarations and Definitions */
#include <string>
#include <iostream>
using namespace std;
extern int yylex();
void yyerror(string s);
%}

%token IDENTIFIER CONSTANT STRING_LITERAL SIZEOF
%token PTR_OP INC_OP DEC_OP LEFT_OP RIGHT_OP LE_OP GE_OP EQ_OP NE_OP
%token AND_OP OR_OP MUL_ASSIGN DIV_ASSIGN MOD_ASSIGN ADD_ASSIGN
%token SUB_ASSIGN LEFT_ASSIGN RIGHT_ASSIGN AND_ASSIGN
%token XOR_ASSIGN OR_ASSIGN TYPE_NAME
%token TYPEDEF EXTERN STATIC AUTO REGISTER
%token CHAR SHORT INT LONG SIGNED UNSIGNED FLOAT DOUBLE CONST RESTRICT VOLATILE VOID
%token BOOL COMPLEX IMAGINARY
%token INLINE
%token STRUCT UNION ENUM ELLIPSIS
%token CASE DEFAULT IF ELSE SWITCH WHILE DO FOR GOTO CONTINUE BREAK RETURN
%start translation_unit

%%
//1.Expression

primary_expression
    : IDENTIFIER
    | CONSTANT
    | STRING_LITERAL
    | '(' expression ')'
    ;
postfix_expression
    : primary_expression
    | postfix_expression '[' expression ']'
    | postfix_expression '(' argument_expression_list_opt ')'
    | postfix_expression '.' IDENTIFIER
    | postfix_expression PTR_OP IDENTIFIER
    | postfix_expression INC_OP
    | postfix_expression DEC_OP
    | '(' type_name ')' '{' initializer_list '}'
    | '(' type_name ')' '{' initializer_list ',' '}'
    ;

argument_expression_list
    : assignment_expression
    | argument_expression_list ',' assignment_expression
    ;

argument_expression_list_opt
	: argument_expression_list
	|
	;
unary_expression
    : postfix_expression
    | INC_OP unary_expression
    | DEC_OP unary_expression
    | unary_operator cast_expression
    | SIZEOF unary_expression
    | SIZEOF '(' type_name ')'
    ;

unary_operator
    : '&'
    | '*'
    | '+'
    | '-'
    | '~'
    | '!'
    ;

cast_expression
    : unary_expression
    | '(' type_name ')' cast_expression
    ;

multiplicative_expression
    : cast_expression
    | multiplicative_expression '*' cast_expression
    | multiplicative_expression '/' cast_expression
    | multiplicative_expression '%' cast_expression
    ;

additive_expression
    : multiplicative_expression
    | additive_expression '+' multiplicative_expression
    | additive_expression '-' multiplicative_expression
    ;

shift_expression
    : additive_expression
    | shift_expression LEFT_OP additive_expression
    | shift_expression RIGHT_OP additive_expression
    ;
relational_expression
    : shift_expression
    | relational_expression '<' shift_expression
    | relational_expression '>' shift_expression
    | relational_expression LE_OP shift_expression
    | relational_expression GE_OP shift_expression
    ;
equality_expression
    : relational_expression
    | equality_expression EQ_OP relational_expression
    | equality_expression NE_OP relational_expression
    ;

and_expression
    : equality_expression
    | and_expression '&' equality_expression
    ;

exclusive_or_expression
    : and_expression
    | exclusive_or_expression '^' and_expression
    ;
inclusive_or_expression
    : exclusive_or_expression
    | inclusive_or_expression '|' exclusive_or_expression
    ;
logical_and_expression
    : inclusive_or_expression
    | logical_and_expression AND_OP inclusive_or_expression
    ;
logical_or_expression
    : logical_and_expression
    | logical_or_expression OR_OP logical_and_expression
    ;
conditional_expression
    : logical_or_expression
    | logical_or_expression '?' expression ':' conditional_expression
    ;
assignment_expression
    : conditional_expression
    | unary_expression assignment_operator assignment_expression
    ;

assignment_operator
    : '='
    | MUL_ASSIGN
    | DIV_ASSIGN
    | MOD_ASSIGN
    | ADD_ASSIGN
    | SUB_ASSIGN
    | LEFT_ASSIGN
    | RIGHT_ASSIGN
    | AND_ASSIGN
    | XOR_ASSIGN
    | OR_ASSIGN
    ;
expression
    : assignment_expression
    | expression ',' assignment_expression
    ;
constant_expression
    : conditional_expression
    ;


//2.Declarations

declaration
    : declaration_specifiers init_declarator_list_opt';'
    ;

declaration_specifiers
    : storage_class_specifier declaration_specifiers_opt
    | type_specifier declaration_specifiers_opt
    | type_qualifier declaration_specifiers_opt
    | function_specifier declaration_specifiers_opt
    ;
declaration_specifiers_opt
	: declaration_specifiers
	|
	;

init_declarator_list
    : init_declarator
    | init_declarator_list ',' init_declarator
    ;
init_declarator_list_opt
	: init_declarator_list
	|
	;

init_declarator
    : declarator
    | declarator '=' initializer
    ;
storage_class_specifier
    : EXTERN
    | STATIC
    | AUTO
    | REGISTER
    ;

type_specifier
    : VOID
    | CHAR
    | SHORT
    | INT
    | LONG
    | FLOAT
    | DOUBLE
    | SIGNED
    | UNSIGNED
    | TYPE_NAME
    | BOOL
    | COMPLEX
    | IMAGINARY
    | enum_specifier
    ;

specifier_qualifier_list
    : type_specifier specifier_qualifier_list_opt
    | type_qualifier specifier_qualifier_list_opt
    ;
specifier_qualifier_list_opt
	:specifier_qualifier_list
	|
	;
enum_specifier
    : ENUM '{' enumerator_list '}'
    | ENUM IDENTIFIER '{' enumerator_list '}'
    | ENUM '{' enumerator_list ',' '}'
    | ENUM IDENTIFIER '{' enumerator_list ',' '}'
    | ENUM IDENTIFIER
    ;
enumerator_list
    : enumerator
    | enumerator_list ',' enumerator
    ;
enumerator
    : enumeration_constant
    | enumeration_constant '=' constant_expression
    ;
enumeration_constant
    : IDENTIFIER
    ;
type_qualifier
    : CONST
    | RESTRICT
    | VOLATILE
    ;
function_specifier
    : INLINE
declarator
    : pointer direct_declarator
    | direct_declarator
    ;


direct_declarator 
    : IDENTIFIER
    | '(' declarator ')'
    | direct_declarator '[' type_qualifier_list_opt assignment_expression_opt ']'
    | direct_declarator '[' STATIC type_qualifier_list_opt assignment_expression ']'
    | direct_declarator '[' type_qualifier_list STATIC assignment_expression ']'
    | direct_declarator '[' type_qualifier_list_opt '*' ']'
    | direct_declarator '(' parameter_type_list ')'
    | direct_declarator '(' identifier_list_opt ')'
    ;
identifier_list_opt
    : identifier_list
    |
    ;
type_qualifier_list_opt
    : type_qualifier_list
    |
    ;
assignment_expression_opt
    : assignment_expression
    |
    ;
pointer
    : '*'
    | '*' type_qualifier_list
    | '*' pointer
    | '*' type_qualifier_list pointer
    ;
type_qualifier_list
    : type_qualifier
    | type_qualifier_list type_qualifier
    ;
parameter_type_list
    : parameter_list
    | parameter_list ',' ELLIPSIS
    ;
parameter_list
    : parameter_declaration
    | parameter_list ',' parameter_declaration
    ;
parameter_declaration
    : declaration_specifiers declarator
    | declaration_specifiers
    ;

identifier_list
    : IDENTIFIER
    | identifier_list ',' IDENTIFIER
    ;

type_name
    : specifier_qualifier_list
    ;

initializer
    : assignment_expression
    | '{' initializer_list '}'
    | '{' initializer_list ',' '}'
    ;

initializer_list
    : initializer
    | designation initializer
  	| initializer_list ',' initializer
    | initializer_list ',' designation initializer
    ;

designation
    : designator_list '='
    ;

designator_list
    : designator
    | designator_list designator
    ;
designator
    : '[' constant_expression ']'
    | '.' IDENTIFIER
    ;


// 3.Statement

statement
    : labeled_statement
    | compound_statement
    | expression_statement
    | selection_statement
    | iteration_statement
    | jump_statement
    ;
labeled_statement
    : IDENTIFIER ':' statement
    | CASE constant_expression ':' statement
    | DEFAULT ':' statement
    ;

compound_statement
    :'{' block_item_list '}'
    |'{' '}'
    ;

block_item_list
    : block_item
    | block_item_list block_item
    ;
block_item
    : declaration
    | statement
    ;
expression_statement
    : ';'
    | expression ';'
    ;
selection_statement
    : IF '(' expression ')' statement
    | IF '(' expression ')' statement ELSE statement
    | SWITCH '(' expression ')' statement
    ;
iteration_statement
    : WHILE '(' expression ')' statement
    | DO statement WHILE '(' expression ')' ';'
    | FOR '(' expression_statement expression_statement ')' statement
    | FOR '(' expression_statement expression_statement expression ')' statement
    | FOR '(' declaration expression_statement ')' statement
    | FOR '(' declaration expression_statement expression ')' statement
    ;
jump_statement
    : GOTO IDENTIFIER ';'
    | CONTINUE ';'
    | BREAK ';'
    | RETURN ';'
    | RETURN expression ';'
    ;


// 4. External Definitions

translation_unit
    : external_declaration
    | translation_unit external_declaration
    ;

external_declaration
    : function_definition
    | declaration
    ;

function_definition
    : declaration_specifiers declarator declaration_list compound_statement
    | declaration_specifiers declarator compound_statement
    ;
declaration_list
    :declaration
    |declaration_list declaration
    ;


%%
void yyerror(string s) {
std::cout<<s<<std::endl;
}

