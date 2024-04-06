with Ada.Wide_Wide_Characters.Handling; use Ada.Wide_Wide_Characters.Handling;

package body Expression_Parser is

   function To_Unbounded_Wide_Wide_String
     (Char : Wide_Wide_Character) return Unbounded_Wide_Wide_String is
     (Null_Unbounded_Wide_Wide_String & Char);

   function Tokenize
     (Expression : Wide_Wide_String) return Token_Vectors.Vector
   is

      Token_Operation_Map : constant Token_Type_Hashed_Maps.Map :=
        ["+" => Addition, "-" => Subtraction, "*" => Multiplication,
        "/"  => Division];

      Tokens : Token_Vectors.Vector;
      Buffer : String_Token :=
        (Kind    => None, Value => To_Unbounded_Wide_Wide_String (""),
         Has_Dot => False);
   begin

      for i in Expression'Range loop

         if Is_Decimal_Digit (Expression (i)) then
            if Buffer.Kind = Number then
               Buffer :=
                 (Kind    => Number, Value => Buffer.Value & Expression (i),
                  Has_Dot => <>);
            else
               Buffer :=
                 (Kind    => Number,
                  Value   => To_Unbounded_Wide_Wide_String (Expression (i)),
                  Has_Dot => False);
            end if;

         elsif Expression (i) = '.' then
            if Buffer.Kind = Number and then not Buffer.Has_Dot then
               Buffer :=
                 (Kind    => Number, Value => Buffer.Value & Expression (i),
                  Has_Dot => True);
            else
               if Buffer.Kind = Number then
                  if Buffer.Value.Element (Buffer.Value.Length) = '.' then
                     Buffer.Value := Buffer.Value & '0';
                  end if;
                  Tokens.Append (Buffer);
               end if;

               Buffer :=
                 (Kind    => None,
                  Value   => To_Unbounded_Wide_Wide_String (Expression (i)),
                  Has_Dot => <>);
               Tokens.Append (Buffer);
            end if;

         else
            if Buffer.Kind = Number then
               Tokens.Append (Buffer);
            end if;

            if Token_Operation_Map.Contains (Expression (i) & "") then
               Buffer :=
                 (Kind    => Token_Operation_Map.Element (Expression (i) & ""),
                  Value   => To_Unbounded_Wide_Wide_String (Expression (i)),
                  Has_Dot => <>);
               Tokens.Append (Buffer);
            else
               Buffer :=
                 (Kind    => None,
                  Value   => To_Unbounded_Wide_Wide_String (Expression (i)),
                  Has_Dot => <>);
               Tokens.Append (Buffer);
            end if;
         end if;

      end loop;

      if Buffer.Kind = Number then
         Tokens.Append (Buffer);
      end if;

      return Tokens;
   end Tokenize;

end Expression_Parser;
