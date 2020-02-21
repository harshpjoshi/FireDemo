import 'package:firedemo/models/user.dart';
import 'package:firedemo/services/firestore_service.dart';
import 'package:firedemo/utils/paths.dart';
import 'package:meta/meta.dart';

class FirestoreUserService{
//  static final String uid;
//  FirestoreUserService({@required this.uid}) : assert(uid != null);

   final String uid;

   final _service = FirestoreService.instance;

  FirestoreUserService(this.uid);

   Future<void> setUser(User job) async => await _service.setData(
    path: FirestorePath.user(uid, job.id),
    data: job.toJson(),
  );

  Future<void> deleteUser(User job) async {
    // delete where entry.jobId == job.jobId
    final allEntries = await entriesStream(job: job).first;
    for (User entry in allEntries) {
      if (entry.id == job.id) {
        await deleteoneUser(entry);
      }
    }
    // delete job
    await _service.deleteData(path: FirestorePath.user(uid, job.id));
  }

  Stream<User> userStream({@required String jobId}) => _service.documentStream(
    path: FirestorePath.user(uid, jobId),
    builder: (data, documentId) => User.fromMap(data, documentId),
  );

  Stream<List<User>> usersStream() => _service.collectionStream(
    path: FirestorePath.users(uid),
    builder: (data, documentId) => User.fromMap(data, documentId),
  );

  Future<void> deleteoneUser(User entry) async =>
      await _service.deleteData(path: FirestorePath.user(uid, entry.id));

  Stream<List<User>> entriesStream({User job}) =>
      _service.collectionStream<User>(
        path: FirestorePath.users(uid),
        queryBuilder: job != null
            ? (query) => query.where('jobId', isEqualTo: job.id)
            : null,
        builder: (data, documentID) => User.fromMap(data, documentID),
      );
}