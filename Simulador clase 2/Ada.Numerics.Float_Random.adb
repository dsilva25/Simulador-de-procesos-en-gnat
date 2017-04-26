package Ada.Numerics.Float_Random is
 
   -- Basic facilities
   type Generator is limited private;
   subtype Uniformly_Distributed is Float range 0.0 .. 1.0;
 
   function Random (Gen : Generator) return Uniformly_Distributed;
   procedure Reset (Gen       : in Generator;
                    Initiator : in Integer);
   procedure Reset (Gen       : in Generator);
 
   -- Advanced facilities
   type State is private;
   procedure Save  (Gen        : in  Generator;
                    To_State   : out State);
   procedure Reset (Gen        : in  Generator;
                    From_State : in  State);
   Max_Image_Width : constant := implementation-defined integer value;
   function Image (Of_State    : State)  return String;
   function Value (Coded_State : String) return State;
 
private
   ... -- not specified by the language
end Ada.Numerics.Float_Random;