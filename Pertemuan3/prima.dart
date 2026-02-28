void main(){
  String nama = "Nanda Ricco Satria Indrawan";
  int nim = 244107060058;

  for (int i = 2; i <= 201; i++){
    bool isPrima = true;
    for (int j = 2; j <= i / 2; j++){
      if (i % j == 0){
        isPrima = false;
        break;
      }
    }

    if (isPrima){
      print("Bilangan Prima: $i | Nama: $nama | NIM: $nim");
    }
  }
}
