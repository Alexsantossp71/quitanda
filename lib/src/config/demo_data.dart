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

// ───────────────────── FRUTAS ─────────────────────

final List<ItemModel> demoFruits = [
  ItemModel(
    id: 'fruta-01',
    itemName: 'Maçã Gala',
    imgUrl: 'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?w=300&h=300&fit=crop',
    price: 5.49,
    unit: 'kg',
    description: 'Maçã gala fresca e selecionada. Perfeita para lanches e sucos naturais. Rica em vitaminas e fibras.',
  ),
  ItemModel(
    id: 'fruta-02',
    itemName: 'Uva Thompson',
    imgUrl: 'https://images.unsplash.com/photo-1537640538966-79f369143f8f?w=300&h=300&fit=crop',
    price: 7.89,
    unit: 'kg',
    description: 'Uvas Thompson sem sementes, doces e suculentas. Ideais para consumo in natura ou em saladas de frutas.',
  ),
  ItemModel(
    id: 'fruta-03',
    itemName: 'Goiaba Vermelha',
    imgUrl: 'https://images.unsplash.com/photo-1588252303782-cb80119abd6d?w=300&h=300&fit=crop',
    price: 11.50,
    unit: 'kg',
    description: 'Goiaba vermelha fresca, rica em vitamina C. Perfeita para sucos, doces e consumo direto.',
  ),
  ItemModel(
    id: 'fruta-04',
    itemName: 'Kiwi Verde',
    imgUrl: 'https://images.unsplash.com/photo-1585059895524-72f83aca3805?w=300&h=300&fit=crop',
    price: 2.99,
    unit: 'un',
    description: 'Kiwi verde importado, sabor azedinho e refrescante. Excelente fonte de vitamina K e potássio.',
  ),
  ItemModel(
    id: 'fruta-05',
    itemName: 'Manga Palmer',
    imgUrl: 'https://images.unsplash.com/photo-1553279768-865429fa0078?w=300&h=300&fit=crop',
    price: 3.49,
    unit: 'un',
    description: 'Manga Palmer do Nordeste, doce e com pouca fibra. Uma das mangas mais populares do Brasil.',
  ),
  ItemModel(
    id: 'fruta-06',
    itemName: 'Mamão Formosa',
    imgUrl: 'https://images.unsplash.com/photo-1619566636858-adf3ef46400b?w=300&h=300&fit=crop',
    price: 6.99,
    unit: 'kg',
    description: 'Mamão formoso maduro, polpa vermelha e doce. Rico em papaína e vitaminas A e C.',
  ),
];

// ───────────────────── LEGUMES ─────────────────────

final List<ItemModel> demoVegetables = [
  ItemModel(
    id: 'leg-01',
    itemName: 'Cenoura',
    imgUrl: 'https://images.unsplash.com/photo-1598170845058-32b9d6a5da37?w=300&h=300&fit=crop',
    price: 4.29,
    unit: 'kg',
    description: 'Cenoura fresca e crocante, rica em betacaroteno e vitamina A. Ideal para saladas, sucos e sopas.',
  ),
  ItemModel(
    id: 'leg-02',
    itemName: 'Tomate Italiano',
    imgUrl: 'https://images.unsplash.com/photo-1546470427-0d4db154ceb8?w=300&h=300&fit=crop',
    price: 6.99,
    unit: 'kg',
    description: 'Tomate italiano maduro, perfeito para molhos e saladas. Rico em licopeno e vitamina C.',
  ),
  ItemModel(
    id: 'leg-03',
    itemName: 'Batata Inglesa',
    imgUrl: 'https://images.unsplash.com/photo-1518977676601-b53f82ber58a?w=300&h=300&fit=crop',
    price: 3.99,
    unit: 'kg',
    description: 'Batata inglesa de qualidade, versátil para frituras, purês e assados. Fonte de carboidratos e potássio.',
  ),
  ItemModel(
    id: 'leg-04',
    itemName: 'Cebola Roxa',
    imgUrl: 'https://images.unsplash.com/photo-1618512496248-a07fe83aa8cb?w=300&h=300&fit=crop',
    price: 5.49,
    unit: 'kg',
    description: 'Cebola roxa crujante com sabor levemente adocicado. Perfeita para saladas e temperos.',
  ),
  ItemModel(
    id: 'leg-05',
    itemName: 'Brócolis',
    imgUrl: 'https://images.unsplash.com/photo-1459411552884-841db9b3cc2a?w=300&h=300&fit=crop',
    price: 8.90,
    unit: 'kg',
    description: 'Brócolis fresco e verde, riquíssimo em nutrientes. Excelente refogado, no vapor ou em sopas.',
  ),
  ItemModel(
    id: 'leg-06',
    itemName: 'Abobrinha Verde',
    imgUrl: 'https://images.unsplash.com/photo-1604784656547-1f5b8e012083?w=300&h=300&fit=crop',
    price: 6.49,
    unit: 'kg',
    description: 'Abobrinha verde italiana, macia e saborosa. Ideal para refogados, ensopados e grelhados.',
  ),
  ItemModel(
    id: 'leg-07',
    itemName: 'Pepino Japonês',
    imgUrl: 'https://images.unsplash.com/photo-1449300079323-02e209d9d3a6?w=300&h=300&fit=crop',
    price: 4.99,
    unit: 'kg',
    description: 'Pepino japonês fino e crocante, com poucas sementes. Perfeito para saladas e sucos detox.',
  ),
  ItemModel(
    id: 'leg-08',
    itemName: 'Pimentão Verde',
    imgUrl: 'https://images.unsplash.com/photo-1563565375-f3fdfdbefa83?w=300&h=300&fit=crop',
    price: 7.79,
    unit: 'kg',
    description: 'Pimentão verde fresco, sabor marcante. Essencial para refogados, molhos e churrascos.',
  ),
  ItemModel(
    id: 'leg-09',
    itemName: 'Espinafre Fresco',
    imgUrl: 'https://images.unsplash.com/photo-1576045057995-568f588f82fb?w=300&h=300&fit=crop',
    price: 9.90,
    unit: 'maço',
    description: 'Espinafre fresco, folhas verde-escuro ricas em ferro. Perfeito para sucos verdes, saladas e refogados.',
  ),
  ItemModel(
    id: 'leg-10',
    itemName: 'Mandioca Descascada',
    imgUrl: 'https://images.unsplash.com/photo-1596547609652-9cf5d8c76921?w=300&h=300&fit=crop',
    price: 5.99,
    unit: 'kg',
    description: 'Mandioca descascada e embalada, macia e pronta para cozinhar. Base de muitos pratos brasileiros.',
  ),
  ItemModel(
    id: 'leg-11',
    itemName: 'Chuchu',
    imgUrl: 'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?w=300&h=300&fit=crop',
    price: 3.49,
    unit: 'kg',
    description: 'Chuchu fresco, leve e digestivo. Muito usado em refogados, sopas e ensopados brasileiros.',
  ),
  ItemModel(
    id: 'leg-12',
    itemName: 'Beterraba',
    imgUrl: 'https://images.unsplash.com/photo-1615485290382-441e4d049cb5?w=300&h=300&fit=crop',
    price: 6.79,
    unit: 'kg',
    description: 'Beterraba vermelha, rica em ferro e nitratos naturais. Excelente para sucos, saladas e cruas.',
  ),
];

// ───────────────────── TEMPEROS ─────────────────────

final List<ItemModel> demoSeasonings = [
  ItemModel(
    id: 'temp-01',
    itemName: 'Alho Selecionado',
    imgUrl: 'https://images.unsplash.com/photo-1540148426945-6cf22a6b2571?w=300&h=300&fit=crop',
    price: 12.90,
    unit: 'kg',
    description: 'Alho nobre selecionado, bulbos inteiros e suculentos. Essencial para temperos e molhos.',
  ),
  ItemModel(
    id: 'temp-02',
    itemName: 'Salsinha Fresca',
    imgUrl: 'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?w=300&h=300&fit=crop',
    price: 3.99,
    unit: 'maço',
    description: 'Salsinha fresca, folhas verde-escuro. Perfeita para finalização de pratos, molhos e saladas.',
  ),
  ItemModel(
    id: 'temp-03',
    itemName: 'Cebolinha Verde',
    imgUrl: 'https://images.unsplash.com/photo-1628556270448-4d4e4148e1b1?w=300&h=300&fit=crop',
    price: 3.49,
    unit: 'maço',
    description: 'Cebolinha verde fresca, sabor suave e aromático. Ideal para temperos, carnes e sopas.',
  ),
  ItemModel(
    id: 'temp-04',
    itemName: 'Manjericão Fresco',
    imgUrl: 'https://images.unsplash.com/photo-1618164435735-413d3b066c9a?w=300&h=300&fit=crop',
    price: 5.99,
    unit: 'maço',
    description: 'Manjericão fresco aromático, folhas verdes e perfumadas. Clássico em molhos italianos e pizzas.',
  ),
  ItemModel(
    id: 'temp-05',
    itemName: 'Orégano Fresco',
    imgUrl: 'https://images.unsplash.com/photo-1596547609652-9cf5d8c76921?w=300&h=300&fit=crop',
    price: 4.49,
    unit: 'maço',
    description: 'Orégano fresco com aroma intenso. Perfeito para pizzas, massas e carnes assadas.',
  ),
  ItemModel(
    id: 'temp-06',
    itemName: 'Coentro Fresco',
    imgUrl: 'https://images.unsplash.com/photo-1595855759920-86582396756a?w=300&h=300&fit=crop',
    price: 2.99,
    unit: 'maço',
    description: 'Coentro fresco, sabor marcante e indispensável na culinária brasileira. Perfeito para sopas e guisados.',
  ),
  ItemModel(
    id: 'temp-07',
    itemName: 'Gengibre Fresco',
    imgUrl: 'https://images.unsplash.com/photo-1583212292454-1fe6229603b7?w=300&h=300&fit=crop',
    price: 14.90,
    unit: 'kg',
    description: 'Gengibre fresco e picante, com propriedades anti-inflamatórias. Usado em chás, sucos e temperos asiáticos.',
  ),
  ItemModel(
    id: 'temp-08',
    itemName: 'Pimenta Dedo-de-Moça',
    imgUrl: 'https://images.unsplash.com/photo-1583119022894-919a68a3d0e3?w=300&h=300&fit=crop',
    price: 8.49,
    unit: 'kg',
    description: 'Pimenta dedo-de-moça vermelha, ardência moderada. Essencial em molhos, conservas e temperos.',
  ),
  ItemModel(
    id: 'temp-09',
    itemName: 'Alecrim Fresco',
    imgUrl: 'https://images.unsplash.com/photo-1515543904323-91a223b94e38?w=300&h=300&fit=crop',
    price: 6.99,
    unit: 'maço',
    description: 'Alecrim fresco com aroma pinhoso. Perfeito para carnes assadas, batatas e pães artesanais.',
  ),
  ItemModel(
    id: 'temp-10',
    itemName: 'Cominho em Pó',
    imgUrl: 'https://images.unsplash.com/photo-1596040033229-a9821ebd058d?w=300&h=300&fit=crop',
    price: 19.90,
    unit: 'pacote',
    description: 'Cominho em pó premium, sabor terroso e quente. Indispensável na culinária brasileira e oriental.',
  ),
];

/// All products combined (used by demo search).
final List<ItemModel> demoProducts = [
  ...demoFruits,
  ...demoVegetables,
  ...demoSeasonings,
];

/// Demo categories with unique products per category.
final List<CategoryModel> demoCategories = [
  CategoryModel(title: 'Frutas', id: 'frutas', items: demoFruits, pagination: 1),
  CategoryModel(title: 'Legumes', id: 'legumes', items: demoVegetables, pagination: 1),
  CategoryModel(title: 'Temperos', id: 'temperos', items: demoSeasonings, pagination: 1),
];

/// Demo orders for the orders tab.
final List<OrderModel> demoOrders = [
  OrderModel(
    id: 'demo-order-001',
    createdDateTime: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
    overdueDateTime: DateTime.now().add(const Duration(days: 3)),
    items: [
      CartItemModel(id: 'ci1', item: demoFruits[0], quantity: 2),
      CartItemModel(id: 'ci2', item: demoVegetables[1], quantity: 3),
    ],
    status: 'delivered',
    copyAndPaste: 'DEM001',
    total: 31.95,
    qrCodeImage: '',
  ),
  OrderModel(
    id: 'demo-order-002',
    createdDateTime: DateTime.now().subtract(const Duration(hours: 5)),
    overdueDateTime: DateTime.now().add(const Duration(hours: 19)),
    items: [
      CartItemModel(id: 'ci3', item: demoSeasonings[0], quantity: 1),
      CartItemModel(id: 'ci4', item: demoVegetables[4], quantity: 2),
    ],
    status: 'pending_payment',
    copyAndPaste: 'DEM002',
    total: 30.70,
    qrCodeImage: '',
  ),
];
