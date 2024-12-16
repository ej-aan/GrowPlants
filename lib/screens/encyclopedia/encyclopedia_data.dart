const List<Map<String, String>> plants = [
  {
    'name': 'Rose',
    'description':
        'Roses are among the most popular and cherished flowers in the world. '
            'Known for their beauty, fragrance, and symbolic meanings, roses are available in various colors, each representing a different sentiment. '
            'They are often used in gardens, bouquets, and special occasions like weddings and anniversaries.',
    'imageAsset': 'assets/rose.jpg',
    'type': 'Flower',
    'size': 'Medium',
    'light': 'Full Sun',
    'water': 'Medium',
    'soil': 'Well-drained',
  },
  {
    'name': 'Tulip',
    'description':
        'Tulips are vibrant and colorful flowers that signify spring and renewal. '
            'Originating from Central Asia, tulips come in a wide range of colors and patterns. '
            'They are highly adaptable and grow well in temperate climates, often used in gardens, parks, and floral displays.',
    'imageAsset': 'assets/tulip.jpg',
    'type': 'Flower',
    'size': 'Medium',
    'light': 'Full Sun',
    'water': 'Medium',
    'soil': 'Sandy',
  },
  {
    'name': 'Cactus',
    'description':
        'Cacti are unique and hardy plants adapted to survive in harsh desert environments. '
            'They store water in their thick, fleshy stems and are known for their spiny exterior. '
            'Some cacti produce beautiful blooms, adding a splash of color to arid landscapes.',
    'imageAsset': 'assets/cactus.jpg',
    'type': 'Succulent',
    'size': 'Small',
    'light': 'Full Sun',
    'water': 'Low',
    'soil': 'Sandy',
  },
  {
    'name': 'Avocado',
    'description': 'Avocado, is a versatile fruit native to Central America. '
        'Its creamy texture and high nutrient content make it a popular choice for various dishes, including salads, smoothies, and sandwiches. '
        'Avocado trees are evergreen and thrive in tropical and subtropical climates.',
    'imageAsset': 'assets/alpukat.jpg',
    'type': 'Fruit',
    'size': 'Large',
    'light': 'Full Sun',
    'water': 'High',
    'soil': 'Well-drained',
  },
  {
    'name': 'Sawi',
    'description':
        'Sawi, also known as mustard greens, is a leafy vegetable widely used in Asian cuisine. '
            'Rich in vitamins and minerals, sawi is easy to grow and thrives in cooler climates. '
            'It is often stir-fried, steamed, or added to soups for its distinct flavor.',
    'imageAsset': 'assets/sawi.jpg',
    'type': 'Vegetable',
    'size': 'Small',
    'light': 'Partial Shade',
    'water': 'Medium',
    'soil': 'Well-drained',
  },
  {
    'name': 'Trembesi',
    'description':
        'The Trembesi tree, also known as the Rain Tree, is a large and fast-growing tree native to tropical regions. '
            'It is often used for shade in parks and urban areas due to its wide canopy. Trembesi trees are also effective in reducing carbon dioxide.',
    'imageAsset': 'assets/trembesi.jpg',
    'type': 'Tree',
    'size': 'Large',
    'light': 'Full Sun',
    'water': 'Medium',
    'soil': 'Clay',
  },
  {
    'name': 'Japanese Maple',
    'description':
        'The Japanese Maple is a small, ornamental tree known for its beautiful, vibrant foliage that changes colors with the seasons. '
            'It is a popular choice for gardens and landscapes due to its elegant structure and vivid red, orange, or yellow leaves.',
    'imageAsset': 'assets/maple-jepang.jpg',
    'type': 'Tree',
    'size': 'Medium',
    'light': 'Partial Shade',
    'water': 'Medium',
    'soil': 'Well-drained',
  },
  {
    'name': 'Mango',
    'description':
        'The mango tree is a tropical fruit tree known for its sweet and juicy fruits. '
            'Mangoes are highly nutritious and are consumed fresh, in juices, or as dried snacks. The tree requires warm climates and ample sunlight to thrive.',
    'imageAsset': 'assets/mangga.jpg',
    'type': 'Fruit',
    'size': 'Large',
    'light': 'Full Sun',
    'water': 'High',
    'soil': 'Well-drained',
  },
  {
    'name': 'Lemongrass',
    'description':
        'Serai, or lemongrass, is a fragrant herb widely used in cooking and traditional medicine. '
            'It is known for its citrusy aroma and flavor and is a key ingredient in many Asian cuisines, especially soups and teas.',
    'imageAsset': 'assets/serai.jpg',
    'type': 'Herb',
    'size': 'Small',
    'light': 'Full Sun',
    'water': 'Medium',
    'soil': 'Sandy',
  },
  {
    'name': 'Sirih',
    'description':
        'Sirih, or betel leaf, is a climbing plant commonly used in traditional medicine and cultural practices in Asia. '
            'Its leaves have antiseptic properties and are often chewed with betel nut.',
    'imageAsset': 'assets/sirih.jpg',
    'type': 'Herb',
    'size': 'Small',
    'light': 'Partial Shade',
    'water': 'Medium',
    'soil': 'Well-drained',
  },
  {
    'name': 'Ketapang',
    'description':
        'The Ketapang tree, also known as Indian almond, is a fast-growing tree often found along coastlines. '
            'It provides ample shade and produces leaves and nuts that have various uses in traditional medicine and aquariums.',
    'imageAsset': 'assets/ketapang.jpg',
    'type': 'Tree',
    'size': 'Large',
    'light': 'Full Sun',
    'water': 'Medium',
    'soil': 'Sandy',
  },
  {
    'name': 'Rambutan',
    'description':
        'Rambutan is a tropical fruit tree known for its unique, hairy-skinned fruits. '
            'The juicy and sweet flesh of the fruit is highly sought after in Southeast Asia. Rambutan trees thrive in warm, humid conditions.',
    'imageAsset': 'assets/rambutan.jpg',
    'type': 'Fruit',
    'size': 'Medium',
    'light': 'Full Sun',
    'water': 'High',
    'soil': 'Well-drained',
  },
  {
    'name': 'Salam',
    'description':
        'Salam leaves, also known as Indonesian bay leaves, are a staple in Southeast Asian cooking. '
            'The tree produces aromatic leaves used to enhance the flavor of soups, curries, and stews.',
    'imageAsset': 'assets/salam.jpg',
    'type': 'Herb',
    'size': 'Medium',
    'light': 'Partial Shade',
    'water': 'Medium',
    'soil': 'Clay',
  },
  {
    'name': 'Broccoli',
    'description':
        'Broccoli is a nutrient-dense vegetable belonging to the cabbage family. '
            'It is rich in vitamins, minerals, and antioxidants and is commonly used in salads, stir-fries, and steamed dishes.',
    'imageAsset': 'assets/brokoli.jpeg',
    'type': 'Vegetable',
    'size': 'Small',
    'light': 'Full Sun',
    'water': 'Medium',
    'soil': 'Well-drained',
  },
  {
    'name': 'Orchid',
    'description':
        'Orchids are elegant and exotic flowers with intricate designs and vibrant colors. '
            'They are prized for their beauty and long-lasting blooms. '
            'Orchids thrive in humid climates and require proper care, including specific watering and lighting conditions.',
    'imageAsset': 'assets/orchid.jpg',
    'type': 'Flower',
    'size': 'Medium',
    'light': 'Partial Shade',
    'water': 'Medium',
    'soil': 'Well-drained',
  },
  {
    'name': 'Sunflower',
    'description':
        'Sunflowers are tall, cheerful plants known for their bright yellow petals and large central discs. '
            'They are sun-loving flowers that symbolize loyalty and longevity. '
            'Sunflowers are also valued for their seeds, which are a nutritious snack and an excellent source of oil.',
    'imageAsset': 'assets/sunflower.jpg',
    'type': 'Flower',
    'size': 'Large',
    'light': 'Full Sun',
    'water': 'Medium',
    'soil': 'Well-drained',
  },
];
