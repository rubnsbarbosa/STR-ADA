procedure code1 is

   -- Declarando variaveis p/ cod. busy wait loop flag
   vetor: array(1..30) of Character;
   FLAGA: Integer:= 1;
   FLAGB: Integer:= 0;
   FLAGC: Integer:= 0;
   indice: Integer:= 1;
   -- fim das declaracoes do cod. busy wait loop flag
   
   task type THREADA is
   -- 
   end THREADA;
   task body THREADA is
   begin  
      while indice < 29 loop
         while FLAGA = 0 loop
            NULL;
         end loop; 
         vetor(indice):= 'A';
         indice := indice + 1;
         FLAGA := 0;
         FLAGB := 1;
      end loop; 
   end THREADA;
   
   task type THREADB is
   end THREADB;
   task body THREADB is
   begin   
      while indice < 30 loop
         while FLAGB = 0 loop
            NULL;
         end loop;
         vetor(indice):= 'B';
         indice := indice + 1;
         FLAGB := 0;
         FLAGC := 1;
      end loop; 
   end THREADB;
         
   task type THREADC is
   end THREADC;
   task body THREADC is
   begin
      while indice < 31 loop
         while FLAGC = 0 loop
            NULL;
         end loop;
         vetor(indice):= 'C';
         indice := indice + 1;
         FLAGC := 0;
         FLAGA := 1;
      end loop;
      -- printando o vetor
      for i in 1..30 loop
         Put(vetor(i));
      end loop;   
   end THREADC;      
   
   A : THREADA;
   B : THREADB;
   C : THREADC;

begin
  NULL;
end code1;   
