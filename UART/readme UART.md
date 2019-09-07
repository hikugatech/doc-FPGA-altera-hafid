# Teori dari UART

# 1. Cara Kerja UART 
![Gambar 1.1 : Cara Kerja UART](https://raw.githubusercontent.com/masterhafid/doc-FPGA-altera-hafid/master/UART/img/UARTworks.png)
dikutip : http://www.circuitbasics.com/basics-uart-communication/

	a. awal dari UART dimulai dari menaikkan sinyal atau bernilai bit 1. dari bit 1 diturunkan jadi bit 0, dari penurunan inilah UART secara otomatis dimulai.
	b. dari bit 0, selanjutnya di isi data (bisa berupa bit 8-9) dan harus berbentuk biner. sebagai contoh saya ingin mengirimkan character "M", jika dalam bentuk biner berupa 01001101
	c. jika data sudah selesai terkirim, selanjutnya menaikkan dari bit 0 ke 1 atau jika posisi 1 maka diturunkan jadi bit 0 lalu ke bit 1.

# 2. Spesifikasi Alat dan Software

	Spesifikasi Alat dalam percobaan kali ini:	
	FPGA 			: Altera Cyclone II EP2C5T144C8N @ 50 MHZ, 4608 LUs
	Software 		: Arduino IDE dan Quartus II 13.0 sp1
	Serial Communication	: Arduino Uno
	alat-alat lainnya	: Breadboard, kabel, dan 2 buah resistor 1k di buat divinder 
	
	# PERINGATAN, FPGA YANG SAYA PAKAI BERVOLTASE MAKSIMAL 3.3V. JIKA MELEBIHI MAKA AKAN RUSAK.

![Gambar 2.1 : Gambar Alat](https://scontent.fsub8-1.fna.fbcdn.net/v/t1.0-9/70424369_2433225070337291_7530681273237372928_n.jpg?_nc_cat=109&_nc_oc=AQmLCgOpZ4CAnQb5Ikdm8svQ3TRM0Ig-0GBgR02NTEId7mUJnNVByv3pi4NMqLO7sfQ&_nc_ht=scontent.fsub8-1.fna&oh=bdd31ab9db488ff0a80ef91ce9836d88&oe=5E135928)

# 3. Implementasi UART TX
	
	NB : Anda bisa mendownload file programnya di folder ini untuk FPGA

	hal pertama yang harus dilakukan yaitu menentukan frekuensi dan bautrate dahulu. frekuensi ini untuk membuat delay dari FPGA dan tick nya. lalu menggunakan rumus 

		Tick UART = Frekuensi / Baudrate

# Pengiriman Data 8 Bit 
	a. buat simple program untuk mengirim 8 bit data atau 1 character misal "M". lalu dirubah ke dalam biner dengan menggunakan CONV_STD_LOGIC_VECTOR() dan menggunakan char'pos. 
	b. pengiriman data harus di balik. misal huruf "M" dengan biner 01001101 di balik menjadi 10110010. 
	c. menentukan stop bit bisa menggunakan "if" dengan perbandingan panjang vector (kalau di bahasa komputer di sebut array) dari biner huruf "M".
	d. pembuatan mode disini yaitu untuk memisahkan start, data, dan stop. 
	e. gunakan simulation waveform editor untuk meneliti bit dari UART dan mengecek UART bekerja atau tidak. 

# Pengiriman Kalimat data. 
	a. dari simple program diatas, dirubah mengirim banyak bit data atau string misal "Mama muda". lalu dirubah ke dalam biner dengan menggunakan CONV_STD_LOGIC_VECTOR() dan merubah string'pos, lalu untuk bit target dikalikan dengan jumlah vector (array *string di vhdl seperti char* di C++). 
	b. sama seperti pengiriman data 8 bit, data harus di balik. misal kalimat "mama muda" harus di balik menjadi "adum amam" dan biner juga di balik. 
	c. menentukan stop bit sama seperti pengiriman 8 bit data, tapi antar char di kasih stop bit.
	d. pembuatan mode disini yaitu untuk memisahkan start, data, dan stop dari char 1 ke char yang lainnya. jika char 1 udah selesai dan ada char lainnya maka data mode akan berubah jadi 0. 
	e. gunakan simulation waveform editor untuk meneliti bit dari UART dan mengecek UART bekerja atau tidak. 

# 4. Pengujian UART TX

	1. Pengujian pengeriman 8 bit data / 1 char data
![Gambar 4.1.1 : contoh kalimat](https://raw.githubusercontent.com/masterhafid/doc-FPGA-altera-hafid/master/UART/img/TX%208%20bit%20data%201.png)	
![Gambar 4.1.2 : signal atau bit data](https://raw.githubusercontent.com/masterhafid/doc-FPGA-altera-hafid/master/UART/img/TX%208%20bit%20data%202.png)	
![Gambar 4.1.3 : di serial arduino](https://raw.githubusercontent.com/masterhafid/doc-FPGA-altera-hafid/master/UART/img/TX%208%20bit%20data%203.png)	

	2. Pengujian pengiriman kalimat data
![Gambar 4.2.1 : contoh kalimat](https://raw.githubusercontent.com/masterhafid/doc-FPGA-altera-hafid/master/UART/img/TX%20Multiple%20data%201.png)	
![Gambar 4.2.2 : signal atau bit data](https://raw.githubusercontent.com/masterhafid/doc-FPGA-altera-hafid/master/UART/img/TX%20Multiple%20data%202.png)	
![Gambar 4.2.3 : di serial arduino](https://raw.githubusercontent.com/masterhafid/doc-FPGA-altera-hafid/master/UART/img/TX%20Multiple%20data%203.png)

# Daftar Pustaka
[1] . http://www.circuitbasics.com/basics-uart-communication/
