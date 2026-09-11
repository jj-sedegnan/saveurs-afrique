import 'package:flutter/material.dart';

import '../models/recipe.dart';

/// Jeu de données initial : recettes emblématiques du continent africain.
///
/// Cette liste est la SEULE source de données « en dur » de l'application.
/// Les widgets reçoivent ces données via le repository / le store et ne
/// définissent jamais de recette eux-mêmes.
const List<Recipe> kSeedRecipes = [
  Recipe(
    id: 'thieboudienne',
    name: 'Thiéboudienne',
    country: 'Sénégal',
    category: 'Plats principaux',
    description:
        "Le « riz au poisson » national sénégalais : riz rouge parfumé au "
        "concentré de tomate, accompagné de poisson farci et de légumes "
        "mijotés. Un plat de fête inscrit au patrimoine de l'UNESCO.",
    minutes: 90,
    servings: 6,
    difficulty: Difficulty.hard,
    hue: 205,
    icon: Icons.set_meal,
    ingredients: [
      '600 g de riz brisé',
      '2 poissons entiers (carpe ou bar)',
      '150 g de concentré de tomate',
      '1 chou moyen',
      '4 carottes',
      '2 maniocs',
      '1 patate douce',
      '2 oignons, 3 gousses d\u0027ail',
      '2 cubes de bouillon, piment, nététou',
    ],
    steps: [
      'Vider et laver les poissons, puis les farcir avec persil, ail, '
          'oignon et piment mixés.',
      'Faire revenir oignon et concentré de tomate dans une marmite à '
          'feu moyen.',
      'Ajouter de l\u0027eau, le bouillon et les légumes coupés en gros '
          'morceaux ; laisser mijoter 30 min.',
      'Retirer les légumes et le poisson, cuire le riz lavé dans ce '
          'bouillon jusqu\u0027à absorption complète.',
      'Servir le riz dans un grand plat, disposer le poisson et les '
          'légumes sur le dessus.',
    ],
  ),
  Recipe(
    id: 'yassa',
    name: 'Poulet Yassa',
    country: 'Sénégal',
    category: 'Plats principaux',
    description:
        "Poulet mijoté dans une sauce onctueuse aux oignons confits et au "
        "citron, à la fois sucré-salé et acidulé. Le grand classique "
        "convivial des déjeuners en famille.",
    minutes: 70,
    servings: 4,
    difficulty: Difficulty.medium,
    hue: 45,
    icon: Icons.lunch_dining,
    ingredients: [
      '1 poulet découpé en morceaux',
      '5 oignons émincés',
      '4 citrons verts',
      '3 cuillères à soupe de moutarde',
      '4 gousses d\u0027ail',
      '2 feuilles de laurier',
      '2 cubes de bouillon',
      'Huile, sel, poivre',
    ],
    steps: [
      'Mariner le poulet 2 h (ou toute une nuit) avec oignons, jus de '
          'citron, ail, laurier, sel et poivre.',
      'Faire dorer les morceaux de poulet dans l\u0027huile, puis réserver.',
      'Confire les oignons de la marinade dans la même marmite.',
      'Remettre le poulet, ajouter la moutarde délayée dans un verre d\u0027eau.',
      'Laisser mijoter 35 min jusqu\u0027à ce que la soit onctueuse.',
      'Servir avec du riz blanc.',
    ],
  ),
  Recipe(
    id: 'mafe',
    name: 'Mafé sauce arachide',
    country: 'Mali',
    category: 'Plats principaux',
    description:
        "Ragoût riche et réconfortant à la pâte d'arachide, commun à toute "
        "l'Afrique de l'Ouest. La sauce crémeuse enrobe la viande et les "
        "légumes fondants.",
    minutes: 80,
    servings: 5,
    difficulty: Difficulty.medium,
    hue: 28,
    icon: Icons.soup_kitchen,
    ingredients: [
      '800 g de bœuf en cubes',
      '4 cuillères à soupe de pâte d\u0027arachide',
      '3 tomates fraîches mixées',
      '1 oignon, 2 gousses d\u0027ail',
      '3 carottes, 1 patate douce',
      '1 cube de bouillon',
      'Huile, sel, piment',
    ],
    steps: [
      'Faire revenir l\u0027oignon et l\u0027ail, puis dorer la viande.',
      'Ajouter les tomates mixées et le bouillon, laisser mijoter 20 min.',
      'Délayer la pâte d\u0027arachide dans 50 cl d\u0027eau tiède et verser dans la marmite.',
      'Ajouter les légumes coupés et poursuivre la cuisson 40 min à feu doux.',
      'Rectifier l\u0027assaisonnement et servir avec du riz.',
    ],
  ),
  Recipe(
    id: 'jollof',
    name: 'Jollof Rice',
    country: 'Nigeria / Ghana',
    category: 'Plats principaux',
    description:
        "Riz rouge mijoté dans une sauce tomate parfumée au poivron et aux "
        "épices. Star ouest-africaine au cœur d'une amicale rivalité entre "
        "Nigéria et Ghana.",
    minutes: 60,
    servings: 6,
    difficulty: Difficulty.medium,
    hue: 12,
    icon: Icons.rice_bowl,
    ingredients: [
      '750 g de riz long grain',
      '6 tomates mûres',
      '3 cuillères à soupe de concentré de tomate',
      '2 poivrons rouges, 2 oignons',
      '3 gousses d\u0027ail, 1 morceau de gingembre',
      '2 feuilles de laurier, 1 cuillère à café de curry',
      '2 cubes de bouillon',
      'Huile, sel',
    ],
    steps: [
      'Mixer tomates, poivrons, oignon, ail et gingembre.',
      'Faire réduire ce mélange 15 min avec le concentré de tomate.',
      'Ajouter les épices, le laurier et le bouillon.',
      'Verser le riz lavé et l\u0027eau à hauteur, couvrir hermétiquement.',
      'Cuire à feu très doux 30 min sans ouvrir jusqu\u0027à absorption complète.',
      'Égrener à la fourchette et servir.',
    ],
  ),
  Recipe(
    id: 'injera',
    name: 'Injera & wots',
    country: 'Éthiopie / Érythrée',
    category: 'Plats principaux',
    description:
        "La grande galerie de teff spongieuse et légèrement acidulée sert à "
        "la fois d'assiette et de couvert. Les ragoûts épicés (wots) sont "
        "disposés au centre et partagés à la main.",
    minutes: 120,
    servings: 4,
    difficulty: Difficulty.hard,
    hue: 150,
    icon: Icons.dinner_dining,
    ingredients: [
      '500 g de farine de teff',
      'Eau tiède et levure (1 à 3 jours de fermentation)',
      '500 g de poulet pour le doro wat',
      '4 oignons rouges, 2 cuillères de berbere',
      'Œufs durs, niter kibbeh (beurre épicé)',
      'Lentilles pour le misir wat',
    ],
    steps: [
      'Délayer la farine de teff dans l\u0027eau et laisser fermenter 24 à 72 h.',
      'Étaler une louche de pâte sur une poêle très chaude, couvrir : la galette cuit sans être retournée.',
      'Pour le doro wat : confire longuement les oignons, ajouter le berbere puis le poulet et mijoter 1 h.',
      'Cuire les lentilles avec oignon et berbere pour le misir wat.',
      'Disposer les wots sur l\u0027injera, ajouter les œufs durs et partager.',
    ],
  ),
  Recipe(
    id: 'ndole',
    name: 'Ndolè',
    country: 'Cameroun',
    category: 'Plats principaux',
    description:
        "Ragoût de feuilles de ndolé (ou épinards), pâte d'arachide, viande "
        "et crevettes. Le plat national camerounais, parfumé et généreux.",
    minutes: 75,
    servings: 5,
    difficulty: Difficulty.medium,
    hue: 128,
    icon: Icons.ramen_dining,
    ingredients: [
      '500 g de feuilles de ndolé ou épinards',
      '300 g de bœuf, 200 g de crevettes',
      '6 cuillères de pâte d\u0027arachide',
      '3 oignons, 4 gousses d\u0027ail',
      '100 g de crevettes séchées moulues',
      'Huile de palme, sel, piment',
    ],
    steps: [
      'Bouillir la viande avec les épices puis la réserver.',
      'Mixer les feuilles de ndolé et les faire revenir.',
      'Incorporer la pâte d\u0027arachide délayée et les crevettes séchées.',
      'Ajouter la viande, l\u0027ail et laisser mijoter 25 min.',
      'Faire revenir les oignons dans l\u0027huile de palme et les verser sur le plat.',
      'Servir avec des miondos ou du plantain frit.',
    ],
  ),
  Recipe(
    id: 'bobotie',
    name: 'Bobotie',
    country: 'Afrique du Sud',
    category: 'Plats principaux',
    description:
        "Gratin de viande hachée épicée aux fruits secs, recouvert d'une "
        "croûte dorée d'œufs et de lait. Un héritage cape malais doux-épicé.",
    minutes: 65,
    servings: 4,
    difficulty: Difficulty.medium,
    hue: 32,
    icon: Icons.bakery_dining,
    ingredients: [
      '600 g de bœuf haché',
      '2 tranches de pain de mie trempées dans du lait',
      '1 oignon, 2 gousses d\u0027ail',
      '2 cuillères de curry, 1 de curcuma',
      '3 cuillères de chutney, 50 g de raisins secs',
      '3 œufs, 25 cl de lait',
      'Feuilles de laurier',
    ],
    steps: [
      'Faire revenir oignon et ail, ajouter la viande et l\u0027émietter.',
      'Incorporer curry, chutney, raisins et le pain essoré.',
      'Verser la préparation dans un plat à four et enfourner 30 min à 180 °C.',
      'Battre les œufs avec le lait et le curcuma, verser sur la viande.',
      'Ajouter les feuilles de laurier et gratiner 20 min jusqu\u0027à ce que la croûte soit dorée.',
    ],
  ),
  Recipe(
    id: 'aloco',
    name: 'Aloco',
    country: 'Côte d\u0027Ivoire',
    category: 'Accompagnements',
    description:
        "Bananes plantain bien mûres frites jusqu'à caramélisation, "
        "souvent servies avec une sauce tomate-oignon pimentée. Le « klako » "
        "de rue par excellence.",
    minutes: 25,
    servings: 3,
    difficulty: Difficulty.easy,
    hue: 82,
    icon: Icons.eco,
    ingredients: [
      '4 bananes plantain très mûres (peau noircie)',
      'Huile de friture',
      '2 tomates, 1 oignon, 1 piment',
      'Sel, 1 cube de bouillon',
    ],
    steps: [
      'Peler les plantains et les couper en tronçons obliques.',
      'Chauffer l\u0027huile et frire les morceaux jusqu\u0027à belle coloration dorée.',
      'Égoutter sur du papier absorbant et saler légèrement.',
      'Pour la sauce : faire revenir oignon et tomates avec le piment et le bouillon.',
      'Servir les plantains chauds nappés de sauce.',
    ],
  ),
  Recipe(
    id: 'amiwo',
    name: 'Amiwo (pâte rouge)',
    country: 'Bénin',
    category: 'Accompagnements',
    description:
        "Pâte de farine de maïs onctueuse cuite dans une sauce tomate et "
        "huile rouge, spécialité fon du sud du Bénin. On la déguste avec du "
        "poulet frit et de la sauce tomate.",
    minutes: 45,
    servings: 4,
    difficulty: Difficulty.medium,
    hue: 8,
    icon: Icons.breakfast_dining,
    ingredients: [
      '300 g de farine de maïs',
      '3 cuillères de concentré de tomate',
      '2 oignons, 1 piment',
      '6 cl d\u0027huile rouge (huile de palme)',
      '1 cube de bouillon',
      '1 l d\u0027eau environ',
    ],
    steps: [
      'Faire revenir un oignon dans l\u0027huile rouge avec le concentré de tomate.',
      'Mouiller avec l\u0027eau, ajouter le bouillon et porter à ébullition.',
      'Verser la farine de maïs en pluie en remuant énergiquement.',
      'Travailler la pâte 15 min à feu doux jusqu\u0027à ce qu\u0027elle se détache.',
      'Façonner des parts et servir avec du poulet frit.',
    ],
  ),
  Recipe(
    id: 'wagasi',
    name: 'Wagasi pané',
    country: 'Bénin (Peul)',
    category: 'Street food',
    description:
        "Fromage frais au lait de vache des éleveurs peuls, frit à la poêle "
        "jusqu'à obtenir une croûte dorée. On le déguste bien chaud, saupoudré "
        "de piment, dans les rues de Cotonou.",
    minutes: 20,
    servings: 2,
    difficulty: Difficulty.easy,
    hue: 48,
    icon: Icons.tapas,
    ingredients: [
      '300 g de wagasi (fromage peul)',
      '2 cuillères de farine de maïs',
      '1 cuillère à café de piment en poudre',
      'Huile pour la friture',
      'Sel, oignon émincé',
      'Pain ou attiéké pour accompagner',
    ],
    steps: [
      'Couper le wagasi en tranches épaisses et les sécher légèrement.',
      'Passer les tranches dans la farine de maïs épicée.',
      'Faire chauffer l\u0027huile dans une poêle.',
      'Frire 2 à 3 min de chaque côté jusqu\u0027à une croûte dorée.',
      'Servir chaud avec l\u0027oignon cru et du piment.',
    ],
  ),
  Recipe(
    id: 'kulikuli',
    name: 'Kuli-kuli',
    country: 'Nigeria / Bénin',
    category: 'Street food',
    description:
        "Bâtonnets et galettes de pâte d'arachide torréfiée frits dans "
        "l'huile. Croquants, salés et légèrement épicés, ils se grignotent "
        "avec une bouillie ou une boisson fraîche.",
    minutes: 50,
    servings: 6,
    difficulty: Difficulty.medium,
    hue: 36,
    icon: Icons.cookie,
    ingredients: [
      '500 g de pâte d\u0027arachide pressée (tourteau)',
      '2 cuillères de gingembre moulu',
      '1 cuillère de piment',
      'Sel',
      'Huile de friture',
    ],
    steps: [
      'Travailler le tourteau d\u0027arachide pour en extraire l\u0027huile restante.',
      'Assaisonner avec gingembre, piment et sel, puis former des bâtonnets.',
      'Laisser reposer les pièces 15 min.',
      'Frire à feu moyen en les retournant jusqu\u0027à ce qu\u0027elles soient dorées.',
      'Laisser refroidir pour qu\u0027elles deviennent croquantes.',
    ],
  ),
  Recipe(
    id: 'puffpuff',
    name: 'Puff-puff',
    country: 'Afrique de l\u0027Ouest',
    category: 'Street food',
    description:
        "Beignets soufflés et moelleux en pâte levée, roulés dans le sucre. "
        "Appelés boflot, mikate ou kala selon les pays, ils se vendent en "
        "cornets dans toutes les rues.",
    minutes: 50,
    servings: 6,
    difficulty: Difficulty.easy,
    hue: 26,
    icon: Icons.donut_large,
    ingredients: [
      '500 g de farine de blé',
      '10 g de levure boulangère',
      '60 g de sucre + 1 sachet de sucre vanillé',
      '30 cl d\u0027eau tiède',
      '1 pincée de sel',
      'Huile de friture',
      'Sucre en poudre pour saupoudrer',
    ],
    steps: [
      'Délayer la levure dans l\u0027eau tiède avec une pincée de sucre.',
      'Mélanger farine, sucres et sel, puis former une pâte molle.',
      'Couvrir et laisser lever 35 min jusqu\u0027à ce que la pâte double.',
      'Prélever des boules à la main huilée et frire à 170 °C en les retournant.',
      'Rouler les beignets dorés dans le sucre et déguster tiède.',
    ],
  ),
  Recipe(
    id: 'thiakry',
    name: 'Thiakry',
    country: 'Sénégal',
    category: 'Desserts',
    description:
        "Perles de mil cuites à la vapeur, nappées de lait caillé sucré "
        "parfumé à la vanille et à la noix de muscade. Le dessert crémeux et "
        "rafraîchissant des chaudes journées.",
    minutes: 40,
    servings: 4,
    difficulty: Difficulty.easy,
    hue: 322,
    icon: Icons.icecream,
    ingredients: [
      '300 g de grains de thiakry (semoule de mil)',
      '50 cl de lait caillé épais',
      '10 cl de lait concentré sucré',
      '1 sachet de sucre vanillé',
      'Noix de muscade râpée',
      '20 g de beurre, une pincée de sel',
    ],
    steps: [
      'Humecter les grains de mil et les cuire à la vapeur 20 min.',
      'Aérer les grains avec un peu de beurre et laisser refroidir.',
      'Mélanger le lait caillé avec le lait concentré et la vanille.',
      'Combiner le tout et parfumer à la muscade.',
      'Réserver au frais au moins 1 h avant de servir.',
    ],
  ),
  Recipe(
    id: 'bissap',
    name: 'Jus de bissap',
    country: 'Afrique de l\u0027Ouest',
    category: 'Boissons',
    description:
        "Infusion glacée de fleurs d'hibiscus d'un rouge profond, acidulée et "
        "désaltérante. La boisson incontournable des cérémonies comme des "
        "journées de chaleur.",
    minutes: 20,
    servings: 6,
    difficulty: Difficulty.easy,
    hue: 340,
    icon: Icons.local_cafe,
    ingredients: [
      '100 g de fleurs d\u0027hibiscus séchées',
      '1,5 l d\u0027eau',
      '80 g de sucre (à ajuster)',
      '1 morceau de gingembre frais',
      'Quelques feuilles de menthe',
      '1 sachet de sucre vanillé (optionnel)',
    ],
    steps: [
      'Rincer les fleurs d\u0027hibiscus à l\u0027eau claire.',
      'Porter l\u0027eau à ébullition avec le gingembre écrasé.',
      'Ajouter les fleurs et laisser infuser 10 min hors du feu.',
      'Filtrer, sucrer encore chaud et ajouter la menthe.',
      'Laisser refroidir puis réfrigérer ; servir bien glacé.',
    ],
  ),
  Recipe(
    id: 'gingembre',
    name: 'Gnamakoudji',
    country: 'Côte d\u0027Ivoire',
    category: 'Boissons',
    description:
        "Jus de gingembre frais piquant et tonique, filtré et servi glacé "
        "avec un peu de citron. Réputé revigorant, il accompagne les "
        "grillades de maquis.",
    minutes: 15,
    servings: 5,
    difficulty: Difficulty.easy,
    hue: 52,
    icon: Icons.coffee,
    ingredients: [
      '200 g de gingembre frais',
      '1 l d\u0027eau fraîche',
      '2 citrons verts',
      '60 g de sucre ou miel',
      '1 pincée de piment de Cayenne (optionnel)',
      'Feuilles de menthe',
    ],
    steps: [
      'Éplucher et couper le gingembre en morceaux.',
      'Le mixer avec la moitié de l\u0027eau jusqu\u0027à obtention d\u0027une pulpe fine.',
      'Filtrer finement en pressant bien la pulpe.',
      'Ajouter le reste d\u0027eau, le jus de citron, le sucre et le piment.',
      'Réfrigérer et servir glacé avec la menthe.',
    ],
  ),
];
