import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:muix_player/infractructure/datasources/song_local_data_source_impl.dart';
import 'package:muix_player/infractructure/repositories/song_local_repository.dart';

final SongLocalDataSourceImpl songLocalDataSourceImpl = SongLocalDataSourceImpl();
final SongLocalRepository songLocalRepository = SongLocalRepository(songLocalDataSourceImpl: songLocalDataSourceImpl);

final songLocalRepositoryProvider = Provider<SongLocalRepository>((ref) { 
  return SongLocalRepository(songLocalDataSourceImpl: songLocalDataSourceImpl);
});

// Define un proveedor para manejar el estado de las reservas
// final bookingsProvider = StateNotifierProvider<BookingsNotifier, BookingsState>((ref) {
//   return BookingsNotifier();
// });

// class BookingsNotifier extends StateNotifier<BookingsState> {
//   BookingsNotifier() : super(BookingsState.initial());

//   Future<void> fetchBookings(BookingsInput input) async {
//     try {
//       // Realiza la lógica de carga de datos aquí
//       final bookingsList = await fetchData(input);

//       // Actualiza el estado con los datos cargados
//       state = BookingsState.success(bookingsList);
//     } catch (error) {
//       // Maneja cualquier error
//       state = BookingsState.failure("Error: $error");
//     }
//   }
// }

// // Define un proveedor FutureProvider para cargar datos asincrónicamente
// final bookingsData = FutureProvider<List<String>>((ref) async {
//   final bookingsState = ref.watch(bookingsProvider.state);

//   if (bookingsState.status == BookingsStatus.initial) {
//     // Inicialmente no hay datos disponibles
//     return [];
//   }

//   if (bookingsState.status == BookingsStatus.success) {
//     // Devuelve la lista de reservas cargadas
//     return bookingsState.bookingsList;
//   }

//   // En caso de error o cualquier otro estado, devuelve una lista vacía o maneja el error apropiadamente
//   return [];
// });
