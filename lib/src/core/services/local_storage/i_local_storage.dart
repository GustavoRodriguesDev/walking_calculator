abstract class IlocalStorage {
  List<String> readStringList(String key);
  Future<void> writeStringList(String key, List<String> itens);
}
