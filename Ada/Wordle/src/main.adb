with Ada.Text_IO; use Ada.Text_IO;
with Ada.Command_Line; use Ada.Command_Line;
with Ada.Strings;           use Ada.Strings;
with Ada.Strings.Bounded;    use Ada.Strings.Bounded;
with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Ada.Numerics.Discrete_Random;

procedure Main is

   package Custom_String is new Ada.Strings.Bounded.Generic_Bounded_Length (Max => 256); use Custom_String; --> Surely that's enough...

   F         : File_Type;
   File_Name : Bounded_String;
   Valid_Words_File_Name : Bounded_String;
   Default_File_Name : constant String := "words.txt";
   Default_Valid_Words_File_Name : constant String := "valid_words.txt";
   Word : String(1 .. 5);
   Word_Count : Integer := 0;
   Selected_Word_Index : Integer;
   SU : Unbounded_String;
   Padding : String := "     ";

   function File_Exists (Name : String) return Boolean is
      The_File : Ada.Text_IO.File_Type;
   begin
      Open (The_File, In_File, Name);
      Close (The_File);
      return True;
   exception
      when Name_Error =>
         return False;
   end File_Exists;

   procedure Validate_Args (Selectable_Word_List_File : in out Bounded_String;
                            Valid_Word_List_File : in out Bounded_String) is
   begin
      if Argument_Count = 1 then -- only the first file was provided, so use it if it exists
         if File_Exists (Argument (Number => 1)) then
            Selectable_Word_List_File := To_Bounded_String (Argument (Number => 1));
         end if;
      elsif Argument_Count = 2 then -- two files were provided, so check each and use them if possible
         if File_Exists (Argument (Number => 1)) then
            Selectable_Word_List_File := To_Bounded_String (Argument (Number => 1));
         end if;

         if File_Exists (Argument (Number => 2)) then
            Valid_Word_List_File := To_Bounded_String (Argument (Number => 2));
         end if;
      end if;
   end Validate_Args;

   subtype Random_Range is Integer range 1 .. 100000;
   package R is new
     Ada.Numerics.Discrete_Random (Random_Range);
   use R;

   G : Generator;

   Guessed_Word : String(1 .. 5);
   Word_Copy : String(1..5);
   Result : String(1..5);
   Attempts : Integer := 6;
   State : Integer := 0;
   Flag : Integer := 0;
begin
   File_Name := To_Bounded_String (Default_File_Name);
   Valid_Words_File_Name := To_Bounded_String (Default_Valid_Words_File_Name);

   Validate_Args (Selectable_Word_List_File => File_Name,
                  Valid_Word_List_File => Valid_Words_File_Name);
   reset(G);
   Open (F, In_File, To_String(File_Name));
   while not End_Of_File (F) loop
      Word := Get_Line (F);
      Word_Count := Word_Count + 1;
   end loop;
   -- Put_Line(Integer'Image(Word_Count));
   Selected_Word_Index := Random(G) mod Word_Count;

   Close (F);

   Open (F, In_File, To_String(File_Name));
   for I in 1 .. Selected_Word_Index loop
      Word := Get_Line(F);
   end loop;
   Close(F);

   -- Put_Line(Word & " @ Line " & Integer'Image(Selected_Word_Index));
   Word_Copy := Word;
   Put_Line("Guess the secret five letter word!");
   Put_Line("An ! means you've guessed the right letter in the right place, ");
   Put_Line("An ? means that letter occurs in the word, but its not in the right spot, ");
   Put_Line("A - means that letter does not occur in the word to be guessed.");
   Put_Line("You have 6 tries, lowercase only, only valid words are accepted, good luck!");
   for I in 1 .. Attempts loop
      Result := "-----";
      Word := Word_Copy;
      loop
         SU := To_Unbounded_String(Get_Line);
         while Length(SU) < 5 loop
            SU := SU & ' ';
         end loop;

         Guessed_Word := To_String(SU)(1..5);
         Flag := 0;
         Open (F, In_File, To_String(Valid_Words_File_Name));
         while not End_Of_File (F) loop
            if Guessed_Word = Get_Line(F) then
               Flag := 1;
               exit;
            end if;
         end loop;
         Close (F);
         exit when Flag = 1;
         Put_Line(Guessed_Word & " is not a valid word, guess again.");
      end loop;

      if Guessed_Word = Word then
         Put_Line("You Got It in" & Integer'Image(I) & " Attempts!" );
         Flag := 10;
         exit;
      end if;

      for C in 1..5 loop
         for W in 1..5 loop
            if (C = W and Word(W) = Guessed_Word(C)) then
               Result(C) := '!';
               Word(C) := '-';
            end if;
         end loop;
      end loop;
      for C in 1..5 loop
         for W in 1..5 loop
            if (Word(W) = Guessed_Word(C) and Result(C) = '-') then
               Result(C) := '?';
               Word(W) := '-';
            end if;
         end loop;
      end loop;
      Put_Line(Result);
   end loop;
   if Flag /= 10 then
      Put_Line("The word was " & Word_Copy & ".");
      Put_Line("Better luck next time.");
   end if;
end Main;
