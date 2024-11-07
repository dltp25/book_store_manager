import '../constant/enum.dart';

class BookTypesModel {
  static Map<BookType, String> typeToDes = {
    BookType.textBook: 'Sách giáo khoa',
    BookType.literature: 'Văn học',
    BookType.child: 'Trẻ em',
    BookType.comic: 'Truyện tranh',
    BookType.science: 'Khoa học - Kỹ thuật',
    BookType.other: 'Khác',
  };

  static Map<String, BookType> codeToType = {
    'bt001': BookType.textBook,
    'bt002': BookType.literature,
    'bt003': BookType.comic,
    'bt004': BookType.child,
    'bt005': BookType.science,
    'bt006': BookType.other,
  };

  static Map<BookType, String> typeToCode = {
    BookType.textBook: 'bt001',
    BookType.literature: 'bt002',
    BookType.comic: 'bt003',
    BookType.child: 'bt004',
    BookType.science: 'bt005',
    BookType.other: 'bt006',
  };

  static Map<String, String> codeToDes = {
    'bt001': 'Sách giáo khoa',
    'bt002': 'Văn học',
    'bt003': 'Truyện tranh',
    'bt004': 'Trẻ em',
    'bt005': 'Khoa học - Kỹ thuật',
    'bt006': 'Khác',
  };
}
