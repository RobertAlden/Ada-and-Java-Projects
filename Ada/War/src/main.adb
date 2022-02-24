with Ada.Numerics.Discrete_Random;
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Containers.Vectors;

procedure Main is
   subtype Random_Range is Integer range 1 .. 54;
   package R is new
     Ada.Numerics.Discrete_Random (Random_Range);
   use R;
   G : Generator;
   X : Random_Range;

   package Deck_Vector is new
     Ada.Containers.Vectors
       (Index_Type   => Natural,
        Element_Type => Integer);

   use Deck_Vector;

   subtype Card is Integer range 2..14;

   mainDeck : Vector;
   DeckA : Vector;
   SpoilsDeckA : Vector;
   DeckB : Vector;
   SpoilsDeckB : Vector;
   CurrentSpoils : Vector;
   Iterations : Integer := 0;
   procedure Shuffle (D1 : in out Vector) is
      Temp : Card;
      K : Integer;
   begin
      For I in D1.First_Index.. D1.Last_Index loop
         X := Random (G);
         K := (X-1) mod Integer(D1.Length);
         Temp := D1(I);
         D1(I) := D1(K);
         D1(K) := Temp;
      end loop;
   end Shuffle;

   procedure PrintDeck(D : Vector) is
   begin
      For I of D loop
         If I >= 2 then
            Put(Integer'Image(I));
         end if;
      end loop;
      Put_Line(" ");
   end PrintDeck;

   procedure DeckInit (V :in out Vector) is
   begin
      For I in 2..14 loop
         For K in 1..4 loop
            V.Append(I);
         end loop;
      end loop;
      V.Append(14);
      V.Append(14);
   end DeckInit;

   function Draw(V : in out Vector) return Card is
      CardOut : Card;
   begin
      CardOut := V.First_Element;
      V.Delete_First;
      return CardOut;
   end Draw;

   procedure Deal(From : in out Vector; To : in out Vector) is
      Temp : Card;
   begin
      Temp := Draw(From);
      To.Append(Temp);
   end Deal;

   procedure Transfer(From : in out Vector; To : in out Vector) is
   begin
      While not From.Is_Empty loop
         Deal(From, To);
      end loop;
   end Transfer;
begin
   Reset (G);
   DeckInit(mainDeck);
   Shuffle(mainDeck);
   While not mainDeck.Is_Empty loop
      Deal(mainDeck, DeckA);
      Deal(mainDeck, DeckB);
   end loop;
   MainLoop : loop
      Iterations := Iterations + 1;
      if DeckA.Is_Empty then
         Transfer(SpoilsDeckA,DeckA);
         Shuffle(DeckA);
      end if;
      if DeckB.Is_Empty then
         Transfer(SpoilsDeckB,DeckB);
         Shuffle(DeckB);
      end if;
      Put("Deck A:");
      PrintDeck(DeckA & SpoilsDeckA);
      Put("Deck B:");
      PrintDeck(DeckB & SpoilsDeckB);
      -- PrintDeck(CurrentSpoils);
      -- PrintDeck();
      -- PrintDeck(SpoilsDeckB);
      --Put_Line(Integer'Image(Integer(DeckA.Length)+Integer(DeckB.Length)+
      --           Integer(SpoilsDeckB.Length)+Integer(CurrentSpoils.Length)
      --        +Integer(SpoilsDeckA.Length)));
      delay 0.25;
      if DeckA.Is_Empty then
         Put_Line("Deck B Wins");
         exit;
      end if;
      if DeckB.Is_Empty then
         Put_Line("Deck A Wins");
         exit;
      end if;

      War : loop
         declare
            CardA : Card := Draw(DeckA);
            CardB : Card := Draw(DeckB);
         begin
            --Put_Line(Integer'Image(CardA) & " vs " & Integer'Image(CardB));
            CurrentSpoils.Append(CardA & CardB);
            if CardB > CardA then
               Transfer(CurrentSpoils,SpoilsDeckB);
               --exit War;
            elsif CardB < CardA then
               Transfer(CurrentSpoils,SpoilsDeckA);
               --exit War;
            end if;
         end;
         exit War when DeckA.Is_Empty or DeckB.Is_Empty;
         end loop War;
   end loop MainLoop;
   Put_Line("Iterations:" & Integer'Image(Iterations));
   end Main;
