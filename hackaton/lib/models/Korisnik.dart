class Korisnik {
  final String id;
  final String ime, prezime;
  final String email;
  final String? slika;
  final String univerzitet;
  final String brTelefona;

  Korisnik({
    required this.id,
    required this.email,
    required this.ime,
    required this.prezime,
    required this.brTelefona,
    required this.slika,
    required this.univerzitet,
  });
}
