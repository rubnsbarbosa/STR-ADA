With Ada.Integer_Text_IO, Ada.Text_IO, Ada.Calendar;
Use Ada.Integer_Text_IO, Ada.Text_IO, Ada.Calendar;

procedure code1 is

   protected type Resource is
       entry Seize;
       procedure Release;
   private
       Busy : Boolean := False;
   end Resource;
   protected body Resource is
      entry Seize when not Busy is
      begin
         Busy := True;

      end Seize;
      procedure Release is
       begin
         Busy := False;

      end Release;
   end Resource;


   type vetorInt is array(1..3) of Integer;

   control1: Resource;
   control2: Resource;
   control3: Resource;

   canais: array(0..5) of Integer := (-1, -1, -1, -1, -1, -1);
   vetorResource: array(0..5) of Resource;
   SendSem: array (0..5) of Resource;
   ReceiveSem: array (0..5) of Resource;
   indice:integer := 1;
   flag1:integer := 1;
   flag2:integer := 0;
   flag3:integer := 0;


   function send_async(mensagem: in Integer; canal : in Integer) return Integer is
   begin
      canais(canal):= mensagem;
      SendSem(canal).Release;
      return 0;
   end send_async;

   function receive(mensagem: out Integer; canal : in Integer) return Integer is
   begin
      SendSem(canal).Seize;
      mensagem:= canais(canal);
      return 0;
   end receive;

   function fa return Integer is
   begin
      return 555;
   end fa;

   function fb return Integer is
   begin
      return 550;
   end fb;

   function fc return Integer is
   begin
      return 10;
   end fc;

   task type TA is
     --entry mostra(Item: in Integer);
   end TA;
   task body TA is
      x:integer;
      y:integer;
      z:integer;
      aux: Integer;
      status: integer := -5;
   begin
      delay 1.0;
      y := 5;
      while y >= 1 and y <= 10 loop
         delay 1.0;
         x := fa;
         aux:= send_async(x, 0);
         aux:= receive(y, 2);
         New_Line;
         Put("TA executando fa");
      end loop;
      --New_Line;

      if y = status then
         y := 5;
         while y >= 1 and y<= 10 loop
            delay 1.0;
            x := fa;
            z :=  fb;
            aux:= send_async(x, 3);
            aux:= receive(y, 2);
            New_Line;
            Put("TA executando fa");
         end loop;

         while True loop
            delay 1.0;
            x := fa;
            y := fb;
            z := fc;
            New_Line;
            Put("TA executando fa fb e fc");
            New_Line;
         end loop;

      else
         aux := send_async(status, 0);
         aux := receive(y, 5);

         while y >= 50 and y <= 100 loop
            delay 1.0;
            x := fa;
            z := fc;
            aux := send_async(x, 0);
            aux := receive(y, 5);
            New_Line;
            Put("TA executando fa e fc");
            New_Line;
         end loop;

         while True loop
            delay 1.0;
            x := fa;
            y := fb;
            z := fc;
            New_Line;
            Put("TA executando fa fb e fc");
            New_Line;
         end loop;

      end if;
   end TA;

   task type TB is
     --entry mostra(Item: in Integer);
   end TB;
   task body TB is
      x:integer;
      y:integer;
      z:integer;
      aux: Integer;
      status:integer := -5;
   begin
      delay 1.0;

      aux:= receive(y, 0);
      while y >= 5 and y <= 10 loop
         delay 1.0;
         x := fb;
         aux:= send_async(x, 1);
         aux:= receive(y, 0);
         New_Line;
         Put("TB executando fb");
      end loop;

      if y = status then
         y := 5;
         while y >= 5 and y<= 10 loop
            delay 1.0;
            x := fb;
            aux:= send_async(x, 5);
            aux:= receive(y, 0);
            New_Line;
            Put("TB executando fb");
         end loop;

         while True loop
            delay 1.0;
            x := fa;
            y := fb;
            z := fc;
            New_Line;
            Put("TB executando fa fb e fc");
            New_Line;
         end loop;

      else
         aux := send_async(status, 1);
         aux := receive(y, 4);

         while y >= 1 and y <= 10 loop
            delay 1.0;
            x := fb;
            z := fa;
            aux := send_async(x, 1);
            aux := receive(y, 4);
            New_Line;
            Put("TB executando fa e fb");
            New_Line;
         end loop;

         while True loop
            delay 1.0;
            x := fa;
            y := fb;
            z := fc;
            New_Line;
            Put("TB executando fa fb e fc");
            New_Line;
         end loop;

      end if;
   end TB;

   task type TC is
     --entry mostra(Item: in Integer);
   end TC;
   task body TC is
      x:integer;
      y:integer;
      z:integer;
      aux: Integer;
      status:integer := -5;
   begin
      delay 1.0;

      aux:= receive(y, 1);
      while y >= 50 and y<= 100 loop
         delay 1.0;
         x := fc;
         aux:= send_async(x, 2);
         aux:= receive(y, 1);
         New_Line;
         Put("TC executando fc");
      end loop;

      if y = status then
         y := 50;
         while y >= 50 and y<= 100 loop
            delay 1.0;
            x := fc;
            aux:= send_async(x, 4);
            aux:= receive(y, 1);
            New_Line;
            Put("TC executando fc");
         end loop;

         while True loop
            delay 1.0;
            x := fa;
            y := fb;
            z := fc;
            New_Line;
            Put("TC executando fa fb e fc");
            New_Line;
         end loop;

      else
         aux := send_async(status, 2);
         aux := receive(y, 3);

         while y >= 5 and y <=10 loop
            delay 1.0;
            x := fc;
            z := fb;
            aux := send_async(x, 2);
            aux := receive(y, 3);
            New_Line;
            Put("TC executando fb e fc");
            New_Line;
         end loop;

         while True loop
            delay 1.0;
            x := fa;
            y := fb;
            z := fc;
            New_Line;
            Put("TC executando fa fb e fc");
            New_Line;
         end loop;

      end if;
   end TC;


   A : TA;
   B : TB;
   C : TC;

begin
   for k in 0..5 loop
      SendSem(k).Seize;
   end loop;
end code1;
