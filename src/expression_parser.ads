with Ada.Strings.Wide_Wide_Unbounded; use Ada.Strings.Wide_Wide_Unbounded;
with Ada.Containers.Vectors;
with Ada.Containers.Indefinite_Hashed_Maps;
with Ada.Strings.Wide_Wide_Hash;

package Expression_Parser is

   type Token_Type is
     (Addition, Subtraction, Multiplication, Division, Number, None);

   type String_Token is record
      Kind    : Token_Type;
      Value   : Unbounded_Wide_Wide_String;
      Has_Dot : Boolean;
   end record;

   type Token is record
      Kind  : Token_Type;
      Value : Float;
   end record;

   package Token_Vectors is new Ada.Containers.Vectors
     (Index_Type => Natural, Element_Type => String_Token);

   package Token_Type_Hashed_Maps is new Ada.Containers.Indefinite_Hashed_Maps
     (Key_Type => Wide_Wide_String, Element_Type => Token_Type,
      Hash     => Ada.Strings.Wide_Wide_Hash, Equivalent_Keys => "=");

   function Tokenize
     (Expression : Wide_Wide_String) return Token_Vectors.Vector;

end Expression_Parser;
