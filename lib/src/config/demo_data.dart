import 'package:greengrocery/src/models/category_model.dart';
import 'package:greengrocery/src/models/item_model.dart';
import 'package:greengrocery/src/models/order_model.dart';
import 'package:greengrocery/src/models/cart_item_model.dart';
import 'package:greengrocery/src/models/user_model.dart';

/// Demo user that bypasses real authentication.
final UserModel demoUser = UserModel(
  id: 'demo-user-001',
  email: 'demo@quitanda.com',
  name: 'Usuário Demo',
  phone: '11 99999-0000',
  cpf: '123.456.789-00',
  password: '1234567',
  token: 'demo-session-token',
);

/// Demo product catalog.
final List<ItemModel> demoProducts = [
  ItemModel(
    id: 'p1',
    itemName: 'Maçã Gala',
    imgUrl: 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=300&h=300&fit=crop',
    price: 5.49,
    unit: 'kg',
    description: 'Maçã gala fresca e selecionada. Perfeita para lanches e sucos naturais. Rica em vitaminas e fibras.',
  ),
  ItemModel(
    id: 'p2',
    itemName: 'Uva Thompson',
    imgUrl: 'https://images.unsplash.com/photo-1537640538966-79f369143f8f?w=300&h=300&fit=crop',
    price: 7.89,
    unit: 'kg',
    description: 'Uvas Thompson sem sementes, doces e suculentas. Ideais para consumo in natura ou em saladas de frutas.',
  ),
  ItemModel(
    id: 'p3',
    itemName: 'Goiaba Vermelha',
    imgUrl: 'https://images.unsplash.com/photo-1588252303782-cb80119abd6d?w=300&h=300&fit=crop',
    price: 11.50,
    unit: 'kg',
    description: 'Goiaba vermelha fresca, rica em vitamina C. Perfeita para sucos, doces e consumo direto.',
  ),
  ItemModel(
    id: 'p4',
    itemName: 'Kiwi Verde',
    imgUrl: 'https://images.unsplash.com/photo-1585059895524-72f83aca3805?w=300&h=300&fit=crop',
    price: 2.99,
    unit: 'un',
    description: 'Kiwi verde importado, sabor azedinho e refrescante. Excelente fonte de vitamina K e potássio.',
  ),
  ItemModel(
    id: 'p5',
    itemName: 'Manga Palmer',
    imgUrl: 'https://images.unsplash.com/photo-1553279768-865429fa0078?w=300&h=300&fit=crop',
    price: 3.49,
    unit: 'un',
    description: 'Manga Palmer do Nordeste, doce e com pouca fibra. Uma das mangos mais populares do Brasil.',
  ),
  ItemModel(
    id: 'p6',
    itemName: 'Mamão Formosa',
    imgUrl: 'https://images.unsplash.com/photo-1619566636858-adf3ef46400b?w=300&h=300&fit=crop',
    price: 6.99,
    unit: 'kg',
    description: 'Mamão formosa maduro, polpa vermelha e doce. Rica em papaína e vitaminas A e C.',
  ),
  ItemModel(
    id: 'p7',
    itemName: 'Banana Prata',
    imgUrl: 'https://images.unsplash.com/photo-1571771894821-ce9b6c11b08e?w=300&h=300&fit=crop',
    price: 4.29,
    unit: 'kg',
    description: 'Banana prata fresca, ideal para vitaminas, bolos e lanches. Fonte de potássio e energia natural.',
  ),
  ItemModel(
    id: 'p8',
    itemName: 'Laranja Pera',
    imgUrl: 'https://images.unsplash.com/photo-1547514701-42782101795e?w=300&h=300&fit=crop',
    price: 5.99,
    unit: 'kg',
    description: 'Laranja pera suculenta e rica em vitamina C. Perfeita para sucos naturais e consumo diário.',
  ),
  ItemModel(
    id: 'p9',
    itemName: 'Morango',
    imgUrl: 'https://images.unsplash.com/photo-1464965911861-746a04b4bca6?w=300&h=300&fit=crop',
    price: 12.90,
    unit: 'kg',
    description: 'Morangos selecionados, frescos e saborosos. Ideais para sobremesas, saladas de frutas e geleias.',
  ),
  ItemModel(
    id: 'p10',
    itemName: 'Abacaxi Pérola',
    imgUrl: 'https://images.unsplash.com/photo-1550258987-190a2d41a8ba?w=300&h=300&fit=crop',
    price: 4.99,
    unit: 'un',
    description: 'Abacaxi pérola doce e suculento. Rico em bromelina e vitamina C. Excelente para sucos e geleias.',
  ),
  ItemModel(
    id: 'p11',
    itemName: 'Melancia',
    imgUrl: 'https://images.unsplash.com/photo-1589984662646-e7b2e4962f18?w=300&h=300&fit=crop',
    price: 3.49,
    unit: 'kg',
    description: 'Melancia sem sementes, refrescante e doce. Perfeita para dias quentes e sobremesas de verão.',
  ),
  ItemModel(
    id: 'p12',
    itemName: 'Limão Siciliano',
    imgUrl: 'https://images.unsplash.com/photo-1590502593747-42a996133562?w=300&h=300&fit=crop',
    price: 8.90,
    unit: 'kg',
    description: 'Limão siciliano aromático, suco abundante. Ideal para drinks, temperos e molhos.',
  ),
];

/// Demo categories with products.
final List<CategoryModel> demoCategories = [
  CategoryModel(title: 'Frutas', id: 'frutas', items: demoProducts.sublist(0, 6), pagination: 1),
  CategoryModel(title: 'Legumes', id: 'legumes', items: demoProducts.sublist(6, 9), pagination: 1),
  CategoryModel(title: 'Temperos', id: 'temperos', items: demoProducts.sublist(9, 12), pagination: 1),
];

/// Demo orders for the orders tab.
final List<OrderModel> demoOrders = [
  OrderModel(
    id: 'demo-order-001',
    createdDateTime: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
    overdueDateTime: DateTime.now().add(const Duration(days: 3)),
    items: [
      CartItemModel(id: 'ci1', item: demoProducts[0], quantity: 2),
      CartItemModel(id: 'ci2', item: demoProducts[4], quantity: 3),
    ],
    status: 'delivered',
    copyAndPaste: 'DEM001',
    total: 21.45,
    qrCodeImage: '',
  ),
  OrderModel(
    id: 'demo-order-002',
    createdDateTime: DateTime.now().subtract(const Duration(hours: 5)),
    overdueDateTime: DateTime.now().add(const Duration(hours: 19)),
    items: [
      CartItemModel(id: 'ci3', item: demoProducts[2], quantity: 1),
      CartItemModel(id: 'ci4', item: demoProducts[8], quantity: 2),
    ],
    status: 'pending_payment',
    copyAndPaste: 'DEM002',
    total: 37.30,
    qrCodeImage: '',
  ),
];
