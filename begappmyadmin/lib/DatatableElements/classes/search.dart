class Search {
  final List<String> filters;
  final List<String> dbColumns;
  final Function search;
  final bool suportArchive; //se tem a opção de dados arquivados

  Search(this.filters, this.dbColumns, this.search,
      {this.suportArchive: false});
}
