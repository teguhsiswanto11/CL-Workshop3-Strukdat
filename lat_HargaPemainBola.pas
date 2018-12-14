program HargaPemainBola;
{I.S.: User memasukkan nomor pilihan menu-menu sisip, hapus, dan tampil}
{F.S.: Menampilkan konten dari menu yang dipilih}
uses crt;
type
//  record untuk LinkedList
    PP = record
      PlayerName :string;
      Price :integer;
   end;//endRecord
type
//  LinkedList
    Point  = ^Data;
    Data   = record
      info : PP;
      next : Point;
      prev : Point;
    end;
//  Stack
    Point2  = ^Stack;
    Stack   = record
      info : String;
      next : Point2;
    end;
//  Queue
    Point3  = ^Queue;
    Queue   = record
      info : String;
      next : Point3;
    end;

var
Elemen                       : PP;
Elemen2                      : string;
Elemen3                      : string;
Awal,Akhir                   : Point;
Top                          : Point2;
Front,Rear                   : Point3;
Pilih,PilihSisip,PilihHapus,
PilihMenuStack,PilihMenuQueue: integer;
Lagi,JenisSisip,isPop,
isDequeue                    : string;
infoHapus                    : boolean;
//------------------------------------------------------------------------------
Procedure Konstruktor();
begin
   Awal := Nil;
   Akhir:= Nil;
end;//endProcedure }
//------------------------------------------------------------------------------
procedure MenuPilihan(var Pilih:integer);
var
   batas:integer;
begin
   clrscr;
      writeln('----------------------------------');
      writeln('|          MENU PILIHAN          |');
      writeln('----------------------------------');
      writeln('|                                |');
      writeln('| 1. Sisip Data (LinkedList)     |');
      writeln('| 2. Hapus Data (LinkedList)     |');
      writeln('| 3. Tampil Data(LinkedList)     |');
      writeln('| 4. Stack                       |');
      writeln('| 5. Queue                       |');
      writeln('| 0. Keluar                      |');
      writeln('----------------------------------');
      writeln;
      write('Masukkan Pilihan Anda : '); readln(Pilih);
      batas:=15;
         while(Pilih<0) or (Pilih>5) do
         begin
           textcolor(yellow);
           gotoxy(1,batas); write('Pilihan menu hanya nomor 1/2/3/4/5/0, Mohon Ulangi !');textcolor(7);
           readln;
           gotoxy(1,batas); clreol;
           gotoxy(25,batas-2); clreol; read(Pilih);
         readln;
         end;//endWhile
end;//endProcedure
//------------------------------------------------------------------------------
procedure IsiData(var Elemen:PP);
begin
   write('Nama Pemain Bola : '); readln(Elemen.Playername);
   write('Harga Pemain $   : '); readln(Elemen.Price);
   writeln;
end;//endProcedure}
//------------------------------------------------------------------------------
//                                                                            //
//                            {SISIP DATA} DOUBLE LINKED LIST                 //
//                                                                            //
//------------------------------------------------------------------------------
procedure MenuPilihanSisip(var PilihSisip:integer);
var
   batas:integer;
begin
   clrscr;
      writeln('----------------------------------');
      writeln('|        MENU SISIP DATA         |');
      writeln('----------------------------------');
      writeln('|                                |');
      writeln('| 1. Sisip Depan                 |');
      writeln('| 2. Sisip Tengah                |');
      writeln('| 3. Sisip Belakang              |');
      writeln('| 0. Kembali Ke Menu Utama       |');
      writeln('----------------------------------');
      writeln;
      write('Masukkan Pilihan Anda : '); readln(PilihSisip);
      batas:=13;
         while(PilihSisip<0) or (PilihSisip>3)do
         begin
           textcolor(yellow);
           gotoxy(1,batas); write('Pilihan menu hanya nomor 1/2/3/0, Mohon Ulangi !');textcolor(7);
           readln;
           gotoxy(1,batas); clreol;
           gotoxy(25,batas-2); clreol; read(PilihSisip);
         readln;
         end;//endWhile
end;//endProcedure}
//------------------------------------------------------------------------------
procedure SisipDepanDouble(Elemen : PP; var Awal,Akhir : Point);
var
   Baru : Point;
begin

      New(Baru);
      Baru^.prev:=Nil;
      Baru^.info:=Elemen;
      if(Awal = Nil)
          then
              begin
                   Akhir:=Baru;
              end
              else
              begin
                   Baru^.next:=Awal;
                   Awal^.prev:=Baru;
              end;
          Awal:=Baru;
end;
//------------------------------------------------------------------------------
procedure SisipBelakangDouble(Elemen : PP; var Awal,Akhir : Point);
var
   Baru : Point;
begin

      New(Baru);
      Baru^.info:=Elemen;
      Baru^.next:=Nil;
      if(Awal = Nil)
          then
              begin
                   Baru^.prev:=Nil;
                   Awal:=Baru;
              end
              else
              begin
                   Baru^.prev:=Akhir;
                   Akhir^.next:=Baru;
              end;
                   Akhir:=Baru;
end;
//------------------------------------------------------------------------------
procedure TanyaSisipTengah;
begin
   writeln;
   writeln('1. Sebelum');
   writeln('2. Sesudah');writeln;
   write('Pilih Sisip Data : ');readln(PilihSisip);
   if(PilihSisip = 1)then
      JenisSisip:='Sebelum'
   else
      JenisSisip:='Sesudah';
end;//endProcedure }
//------------------------------------------------------------------------------
procedure SisipTengahSebelum(Elemen:PP;Bantu:Point);
var
   Baru: Point;
begin
   if(Elemen.PlayerName <> 'stop')then
   begin
      New(Baru);
         Baru^.info:=Elemen;
         Baru^.next:=Bantu;
         Baru^.prev:=Bantu^.prev;
         Bantu^.prev^.next:=Baru;
         Bantu^.prev:=Baru;
   end;
end;//endProcedure }
//------------------------------------------------------------------------------
procedure SisipTengahSesudah(Elemen:PP;Bantu:Point);
var
   Baru: Point;
begin
   if(Elemen.PlayerName <> 'stop')then
   begin
      New(Baru);
         Baru^.info:=Elemen;
         Baru^.next:=Bantu^.next;
         Baru^.prev:=Bantu;
         Bantu^.next^.prev:=Baru;
         Bantu^.next:=Baru;
   end;
end;//endProcedure }
//------------------------------------------------------------------------------
procedure CariTengah_Sisip(Awal,Akhir:Point);
var
   Bantu:Point;
   Ketemu:boolean;
   DataCari:string;
begin
   if(Awal=Akhir)then
   begin
      write(' Data Kurang dari Dua ',#01);readln;
   end
   else
   begin
      TanyaSisipTengah;
      write('Sisip Data ', JenisSisip ,' Data : ');readln(DataCari);

      Bantu:=Awal;
      Ketemu:=false;
         while(not Ketemu)and(Bantu <> nil)do
         begin
            if(Bantu^.info.PlayerName = DataCari)then
               Ketemu:=true
            else
               Bantu:=Bantu^.next;
         end;//endWhile }

      if(Ketemu)then
      begin
         write('Data ',Bantu^.info.PlayerName,' Ditemukan');textcolor(yellow);
         writeln(' | Ketik `stop` pada NamaPemain untuk berhenti mengisi data & 0(nol) pada harga');
         textcolor(7);
         if(JenisSisip='Sebelum')and(Bantu<>Awal)then
            begin
               //SisipSebelum
                writeln;
                Elemen.PlayerName := ' ';
                while(Elemen.PlayerName <> 'stop')do
                begin
                   IsiData(Elemen);
                   SisipTengahSebelum(Elemen,Bantu);
                   writeln;
                end;//endWhile
            end
            else
         if(JenisSisip='Sesudah')and(Bantu<>Akhir)then
            begin
               //SisipSesudah
               writeln;
               Elemen.PlayerName := ' ';
                  while(Elemen.PlayerName <> 'stop')do
                  begin
                     IsiData(Elemen);
                     SisipTengahSesudah(Elemen,Bantu);
                     writeln;
                  end;//endWhile
            end;
      end//endIF jika ditemukan
      else
         writeln('Data Tidak Ditemukan ');
         readln;
      end;//endIF-1 }
end;//endProcedure
//------------------------------------------------------------------------------
//                                                                            //
//                            {HAPUS DATA} DOUBLE LINKED LIST                 //
//                                                                            //
//------------------------------------------------------------------------------
procedure MenuPilihanHapus(var PilihHapus:integer);
var
   batas:integer;
begin
   clrscr;
      writeln('----------------------------------');
      writeln('|          MENU HAPUS            |');
      writeln('----------------------------------');
      writeln('|                                |');
      writeln('| 1. Hapus Depan                 |');
      writeln('| 2. Hapus Tengah                |');
      writeln('| 3. Hapus Belakang              |');
      writeln('| 0. Kembali Ke Menu Utama       |');
      writeln('----------------------------------');
      writeln;
      write('Masukkan Pilihan Anda  : '); readln(PilihHapus);
      batas:=13;
         while(PilihHapus<0) or (PilihHapus>3)do
         begin
           textcolor(yellow);
           gotoxy(1,batas); write('Pilihan menu hanya nomor 1/2/3/0, Mohon Ulangi !');textcolor(7);
           readln;
           gotoxy(1,batas); clreol;
           gotoxy(26,batas-2); clreol; read(PilihHapus);
         readln;
         end;//endWhile
end;//endProcedure}
//------------------------------------------------------------------------------
procedure HapusDepanDouble(var Awal,Akhir:point);
var
   Phapus:Point;
begin
   Phapus:=Awal;
   Elemen:=Phapus^.info;
   if(Awal=Akhir)then
      begin
         Awal:=nil;
         Akhir:=nil;
      end
      else
      begin
         Awal:=Awal^.next;
         Awal^.prev:=Nil;
      end;
      Dispose(Phapus);
end;//endProcedure }
//------------------------------------------------------------------------------
procedure HapusBelakangDouble(var Awal,Akhir:point);
var
   Phapus:Point;
begin
   Phapus:=Akhir;
   Elemen:=Phapus^.info;
   if(Awal=Akhir)then
      begin
         Awal:=nil;
         Akhir:=nil;
      end
      else
      begin
         Akhir:=Akhir^.prev;
         Akhir^.next:=Nil;
      end;
      Dispose(Phapus);
end;//endProcedure }
//------------------------------------------------------------------------------
procedure HapusTengah(Bantu:Point; var Awal,Akhir:point);
var
   Phapus:Point;
begin
   Phapus:=Bantu;
   Elemen:=Phapus^.info;
   if(Awal=Akhir)then
      begin
         Awal:=nil;
         Akhir:=nil;
      end
      else
      begin
         Phapus^.prev^.next:=Phapus^.next;
         Phapus^.next^.prev:=Phapus^.prev;
      end;
      Dispose(Phapus);
end;//endProcedure }
//------------------------------------------------------------------------------
procedure CariTengah_Hapus(var infoHapus:boolean;Awal,Akhir:Point);
var
   Bantu:Point;
   Ketemu:boolean;
   DataCari:string;
begin
   if(Awal=Akhir)then
   begin
      write(' Data Kurang dari Dua ',#01);readln;
   end
   else
   begin
      write('Data yang Akan Dihapus : ');readln(DataCari);

      Bantu:=Awal;
      Ketemu:=false;
         while(not Ketemu)and(Bantu <> nil)do
         begin
            if(Bantu^.info.PlayerName = DataCari)then
               Ketemu:=true
            else
               Bantu:=Bantu^.next;
         end;//endWhile }
         infoHapus:=false;
      if(Ketemu)then
         begin
            writeln('Data ',Bantu^.info.PlayerName,' Ditemukan');
            if(Bantu<>Awal)and(Bantu<>Akhir)then
               begin
                  HapusTengah(Bantu,Awal,Akhir);
                  infoHapus:=true;
               end
               else writeln('Data Harus Di Tengah, Bukan di Awal atau di Akhir !');
      end//endIF jika ditemukan
      else
        writeln('Data Tidak Ditemukan ');
         readln;
      end;//endIF-1 }
end;//endProcedure
//------------------------------------------------------------------------------
//                                                                            //
//                          {TAMPIL DATA}                                     //
//                                                                            //
//------------------------------------------------------------------------------
procedure TampilData(Awal: Point);
{I.S.:                           }
{F.S.:                           }

var
   Bantu : Point;
   i:integer;
begin
   i:=1;
   Bantu := Awal;
   while(Bantu <> Nil) do
   begin
     write(i,'. ');
     write(Bantu^.info.PlayerName,' == $');
     writeln(Bantu^.info.Price);
     Bantu:= Bantu^.next;
     i:=i+1;
   end; //END WHILE
   writeln;
   write('Tekan Enter Untuk kembali!!! ');
   readln;
end;
//------------------------------------------------------------------------------
//                                                                            //
//                            {PUSH & POP} STACK                              //
//                                                                            //
//------------------------------------------------------------------------------
procedure MenuPilihanStack(var PilihMenuStack:integer);
var
   batas:integer;
begin
   clrscr;
      writeln('----------------------------------');
      writeln('|        MENU DATA STACK         |');
      writeln('----------------------------------');
      writeln('|                                |');
      writeln('| 1. Push Data                   |');
      writeln('| 2. Pop Data                    |');
      writeln('| 3. Tampil Data  (Stack)        |');
      writeln('| 0. Kembali Ke Menu Utama       |');
      writeln('----------------------------------');
      writeln;
      write('Masukkan Pilihan Anda : '); readln(PilihMenuStack);
      batas:=13;
         while(PilihMenuStack<0) or (PilihMenuStack>3)do
         begin
           textcolor(yellow);
           gotoxy(1,batas); write('Pilihan menu hanya nomor 1/2/3/0, Mohon Ulangi !');textcolor(7);
           readln;
           gotoxy(1,batas); clreol;
           gotoxy(25,batas-2); clreol; read(PilihMenuStack);
         readln;
         end;//endWhile
end;//endProcedure}
//------------------------------------------------------------------------------
procedure IsiDataStack(var Elemen2:String);
begin
   write('Nama Mantanmu : '); readln(Elemen2);
   writeln;
end;//endProcedure}
//------------------------------------------------------------------------------
function Empty:Boolean;
begin
   Empty := false;
   if (Top = Nil) then Empty:=true;
end;
//------------------------------------------------------------------------------
procedure Push(Elemen2:String; var Top:Point2);
var
   Baru: Point2;
begin
   New(Baru);
   Baru^.info := Elemen2;

   if (Empty)then
      Baru^.next := nil
   else
      Baru^.next := Top;

   Top := Baru;
end;
//------------------------------------------------------------------------------
procedure Pop(var Top:Point2);
var
   Phapus: Point2;
begin
   if(Not Empty)then
      begin
         Phapus  := Top;
         Elemen2 := Top^.info;
         Top     := Top^.next;
         Dispose(Phapus);
      end;
end;
//------------------------------------------------------------------------------
procedure TampilDataStack(Top: Point2);
var
   Bantu : Point2;
   i:integer;
begin
   if(Not Empty)then
   begin
      i:=1;
      Bantu := Top;
      while(Bantu <> Nil) do
      begin
        write(i,'. ');
        writeln(Bantu^.info);
        Bantu:= Bantu^.next;
        i:=i+1;
      end; //END WHILE
         writeln;
      write('Tekan Enter Untuk kembali!!! ');
      end
   else
   begin
      writeln;
      writeln('Stack Kosong');
   end;
   readln;
end;
//------------------------------------------------------------------------------
//                                                                            //
//                            {QUEUE} ENQUEUE & DEQUEUE                       //
//                                                                            //
//------------------------------------------------------------------------------
procedure MenuPilihanQueue(var PilihMenuQueue:integer);
var
   batas:integer;
begin
   clrscr;
      writeln('----------------------------------');
      writeln('|        MENU DATA QUEUE         |');
      writeln('----------------------------------');
      writeln('|                                |');
      writeln('| 1. Enqueue                     |');
      writeln('| 2. Dequeue                     |');
      writeln('| 3. Tampil Data  (Queue)        |');
      writeln('| 0. Kembali Ke Menu Utama       |');
      writeln('----------------------------------');
      writeln;
      write('Masukkan Pilihan Anda : '); readln(PilihMenuQueue);
      batas:=13;
         while(PilihMenuQueue<0) or (PilihMenuQueue>3)do
         begin
           textcolor(yellow);
           gotoxy(1,batas); write('Pilihan menu hanya nomor 1/2/3/0, Mohon Ulangi !');textcolor(7);
           readln;
           gotoxy(1,batas); clreol;
           gotoxy(25,batas-2); clreol; read(PilihMenuQueue);
         readln;
         end;//endWhile
end;//endProcedure}
//------------------------------------------------------------------------------
procedure IsiDataQueue(var Elemen3:String);
begin
   write('Masukkan Nama Orang : '); readln(Elemen3);
   writeln;
end;//endProcedure}
//------------------------------------------------------------------------------
function Kosong:Boolean;
begin
   Kosong:=false;
   if(Rear = nil)then Kosong:=true;
end;
//------------------------------------------------------------------------------
Procedure Enqueue(Elemen3:String; var Front,Rear:Point3);
var
   Baru:Point3;
begin
   New(Baru);
   Baru^.Info:=Elemen3;
   if(Rear = Nil)then
   begin
      Front := Baru;
   end
   else
   begin
      Rear^.Next := Baru;
   end;
   Rear:=Baru;
end;
//------------------------------------------------------------------------------
procedure Dequeue(var Front,Rear:Point3);
var
   Phapus:Point3;
begin
   Phapus:=Front;
   Elemen3:=Phapus^.info;
   if(Front=Rear)then
      begin
         Front:=nil;
         Rear:=nil;
      end
      else
      begin
         Front:=Front^.next;
      end;
      Dispose(Phapus);
end;
//------------------------------------------------------------------------------
procedure TampilDataQueue(Front: Point3);
var
   Bantu : Point3;
   i:integer;
begin
   if(Not Kosong)then
   begin
      i:=1;
      Bantu := Front;
      while(Bantu <> Nil) do
      begin
        write(i,'. ');
        writeln(Bantu^.info);
        Bantu:= Bantu^.next;
        i:=i+1;
      end; //END WHILE
         writeln;
         write('Tekan Enter Untuk kembali!!! ');
      end
   else
   begin
      writeln;
      writeln('Queue Kosong');
   end;
   readln;
end;
//------------------------------------------------------------------------------
begin
   Konstruktor();
   repeat
      clrscr;
      MenuPilihan(Pilih);
      case (pilih) of
         1:begin
            repeat
              clrscr;
              MenuPilihanSisip(PilihSisip);
                 case(PilihSisip)of
                    1:begin
                         clrscr;
                         repeat
                            IsiData(Elemen);
                            SisipDepanDouble(Elemen,Awal,Akhir);
                            write('Mau Masukan Lagi [Y/T] ? '); readln(lagi);
                         until (lagi ='T') or (lagi = 't');
                      end;
                    2:begin
                         CariTengah_Sisip(Awal,Akhir);
                      end;
                    3:begin
                           clrscr;
                           repeat
                                 IsiData(Elemen);
                                 SisipBelakangDouble(Elemen,Awal,Akhir);
                                 write('Mau Masukan Lagi [Y/T] ? '); readln(lagi);
                           until (lagi ='T') or (lagi = 't');
                      end;
                 end; //endcase
            until(PilihSisip = 0);
           end;
         2:begin
              repeat
                 clrscr;
                 MenuPilihanHapus(PilihHapus);
                    case(PilihHapus)of
                       1:begin
                            clrscr;
                            HapusDepanDouble(Awal,Akhir);
                            TampilData(Awal);
                            writeln('Hapus Depan Berhasil ');
                            readln;
                         end;
                      2:begin
                           infoHapus:=false;
                           CariTengah_Hapus(infoHapus,Awal,Akhir);
                           if(infoHapus=true)then
                              begin
                                 clrscr;
                                 TampilData(Awal);
                                 writeln('Hapus Tengah Berhasil ');
                                 readln;
                              end;
                        end;
                      3:begin
                           clrscr;
                           HapusBelakangDouble(Awal,Akhir);
                           TampilData(Awal);
                           writeln('Hapus Belakang Berhasil ');
                           readln;
                        end;
                  end; //endcase
              until(PilihHapus = 0);
           end;
         3:begin
              TampilData(Awal);
           end;
         4:begin
              repeat
                 clrscr;
                 MenuPilihanStack(PilihMenuStack);
                    case(PilihMenuStack)of
                       1:begin
                            clrscr; TextColor(yellow);
                            writeln('Ketik "stop" untuk berhenti input data');
                            writeln;
                            TextColor(7);
                            repeat
                               IsiDataStack(Elemen2);
                               if(Elemen2 <> 'stop')then Push(elemen2,Top);
                            until(Elemen2 = 'stop');
                         end;
                       2:begin
                            if(Empty)then
                            begin
                               writeln;
                               write('Stack Kosong');
                            end
                            else
                            begin
                               write('Hapus data ',Top^.info,' [y/n] ? ');readln(isPop);
                               if (isPop = 'y')then
                                  begin
                                     Pop(Top);
                                     writeln('Data berhasil dihapus');
                                     TampilDataStack(Top);
                                  end
                                  else
                                  begin
                                     writeln;
                                     writeln('Data tidak jadi dihapus');
                                  end;
                            end;//endIF_Empty
                            readln;
                         end;
                       3:begin
                            TampilDataStack(Top);
                         end;
                    end;//endCase
              until(PilihMenuStack = 0);
           end;
         5:begin
              repeat
                 clrscr;
                 MenuPilihanQueue(PilihMenuQueue);
                    case(PilihMenuQueue)of
                       1:begin
                            clrscr; TextColor(yellow);
                            writeln('Ketik "stop" untuk berhenti input data');
                            writeln;
                            TextColor(7);
                            repeat
                               IsiDataQueue(Elemen3);
                               if(Elemen3 <> 'stop')then Enqueue(Elemen3,Front,Rear);
                            until(Elemen3 = 'stop');
                         end;
                       2:begin
                            if(Kosong)then
                            begin
                               writeln;
                               write('Queue Kosong');
                            end
                            else
                            begin
                               write('Hapus data ',Front^.info,' [y/n] ? ');readln(isDequeue);
                               if (isDequeue = 'y')then
                                  begin
                                     Dequeue(Front,Rear);
                                     writeln('Data berhasil dihapus');
                                     TampilDataQueue(Front);
                                  end
                                  else
                                  begin
                                     writeln;
                                     writeln('Data tidak jadi dihapus');
                                  end;
                            end;//endIF_Empty
                            readln;
                         end;
                       3:begin
                            TampilDataQueue(Front);
                         end;
                    end;//endCase
              until(PilihMenuQueue = 0);
           end;//5

   end;//endCase
   until(Pilih = 0);
   readln;
end.

{
Jangan lupa tugasnya membuat fungsi untuk : 
1. Sisip Depan, tengah dan akhir double linked list
2. Hapus depan, tengah, dan akhir double linked list
3. Tampil data
4. Stack (push dan pop)
5. Queue (enqueue dan dequeue)

Selamat mengerjakan
}
