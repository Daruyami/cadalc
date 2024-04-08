with Expression_Parser; use Expression_Parser;

package body Calculator is

   function Token_Calculate (Tokens : Token_Vectors.Vector) return Token is
      type Token_Kind_Priorities is array (Token_Kind'Range) of Token_Kind;

      Priorities : constant Token_Kind_Priorities :=
        [Multiplication, Division, Addition, Subtraction, Number, None];

      Result : Token := (Kind => None, Value => 0.0);
   begin
      for Current_Operation of Priorities loop
         for i in 0 .. Tokens.Last_Index loop
            null;

         end loop;
      end loop;

      return Result;
   end Token_Calculate;

   function Calculate (Expression : Wide_Wide_String) return Float is
      Tokens : Token_Vectors.Vector;
   begin
      for item of Tokenize (Expression) loop
         Tokens.Append (Parse_Value (item));
      end loop;

      return Token_Calculate (Tokens).Value;
   end Calculate;

end Calculator;
