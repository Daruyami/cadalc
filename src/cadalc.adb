with Ada.Wide_Wide_Text_IO;           use Ada.Wide_Wide_Text_IO;
with Ada.Command_Line;                use Ada.Command_Line;
with Ada.Strings;                     use Ada.Strings;
with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
use Ada.Strings.UTF_Encoding.Wide_Wide_Strings;
with Calculator;

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

   Put_Line (Calculator.Calculate (Argument_Line.To_Wide_Wide_String)'Wide_Wide_Image);

end Cadalc;
