with Ada.Wide_Wide_Text_IO;           use Ada.Wide_Wide_Text_IO;
with Ada.Command_Line;                use Ada.Command_Line;
with Ada.Strings;                     use Ada.Strings;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Expression_Parser;

procedure Cadalc is

   procedure Show_Help is
   begin
      Put_Line ("Usage: " & "cadalc ""<expr>""");
   end Show_Help;

   Argument_Line : Unbounded_Wide_Wide_String;

begin

   if Argument_Count = 0 then
      Put_Line ("No arguments provided.");
      Show_Help;
   end if;

   for argument_index in 1 .. Argument_Count loop
      Argument_Line := Argument_Line & Decode (Argument (argument_index));
   end loop;

   declare
      tokens : constant Expression_Parser.Token_Vectors.Vector :=
        Expression_Parser.Tokenize (Argument_Line.To_Wide_Wide_String);
   begin
      for item of tokens loop

         Put_Line ("KIND  => " & item.Kind'Wide_Wide_Image);
         Put_Line
           ("VALUE => " & To_Wide_Wide_String (item.Value)'Wide_Wide_Image);

         if Expression_Parser."=" (item.Kind, Expression_Parser.Number) then
            Put_Line ("HAS_DOT => " & item.Has_Dot'Wide_Wide_Image);

            if item.Has_Dot then
               Put_Line
                 (Float'Wide_Wide_Image
                    (Float'Wide_Wide_Value
                       (To_Wide_Wide_String (item.Value))));
            end if;
         end if;

         New_Line;

      end loop;
   end;

   --  Put_Line (Expression_Parser.Parse (Argument_Line.To_String).Element (0)'Image);

end Cadalc;
