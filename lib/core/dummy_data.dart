class DummyData {
  static const String allCategoryId = '00000000-0000-0000-0000-000000000000';

  // ─── التصنيفات ──────────────────────────────────────────────────────────
  static final List<Map<String, dynamic>> categories = [
    {
      'id': allCategoryId,
      'name': 'الكل',
      'sort_order': 0,
    },
    {
      'id': 'cat_grills',
      'name': 'مشاوي',
      'sort_order': 1,
    },

    {
      'id': 'cat_appetizers',
      'name': 'مقبلات',
      'sort_order': 3,
    },
    {
      'id': 'cat_sandwiches',
      'name': 'ساندويش',
      'sort_order': 4,
    },
    {
      'id': 'cat_soups',
      'name': 'شوربات',
      'sort_order': 5,
    },
    {
      'id': 'cat_sweets',
      'name': 'حلويات',
      'sort_order': 6,
    },
    {
      'id': 'cat_drinks',
      'name': 'مشروبات',
      'sort_order': 7,
    },
  ];

  // ─── قائمة الوجبات ───────────────────────────────────────────────────────
  static final List<Map<String, dynamic>> menuItems = [
    // مشاوي
    {
      'id': 'item_1',
      'category_id': 'cat_grills',
      'name': 'كباب لحم بغدادي مشوي',
      'description':
          'ثلاثة أسياخ من لحم الغنم الطازج المفروم مع التوابل البغدادية الأصيلة، يقدم مع الخبز العراقي الحار والطماطم والبصل المشوي.',
      'price': 14000,
      'image_url':
          'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 20,
      'is_available': true,
      'rating': 4.9,
    },
    {
      'id': 'item_2',
      'category_id': 'cat_grills',
      'name': 'تكة لحم غنم مشوية',
      'description':
          'قطع لحم غنم طرية ومتبلة بالخلطات البغدادية الخاصة ومشوية على الفحم الهادئ، تقدم مع الصمون الحار والخضار المشوية.',
      'price': 16000,
      'image_url':
          'https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 25,
      'is_available': true,
      'rating': 4.8,
    },
    {
      'id': 'item_3',
      'category_id': 'cat_grills',
      'name': 'شيش طاووق على الفحم',
      'description':
          'قطع صدور دجاج متبلة بالثوم والليمون والزبادي مع الأعشاب، مشوية بعناية لتبقى عصارية وشهية مع صلصة الثومية.',
      'price': 12000,
      'image_url':
          'https://images.unsplash.com/photo-1599488615731-7e5c2823ff28?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 18,
      'is_available': true,
      'rating': 4.7,
    },
    {
      'id': 'item_4',
      'category_id': 'cat_grills',
      'name': 'مشكل مشاوي بيت بغداد',
      'description':
          'تشكيلة فاخرة من كباب اللحم، كباب الدجاج، التكة والشيش طاووق، تقدم مع الأرز والخبز الحار والمقبلات المشكلة.',
      'price': 32000,
      'image_url':
          'https://images.unsplash.com/photo-1529692236671-f1f6cf9683ba?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 30,
      'is_available': true,
      'rating': 5.0,
    },

    // أطباق رئيسية
    {
      'id': 'item_5',
      'category_id': 'cat_main',
      'name': 'قوزي لحم غنم على تمن',
      'description':
          'موزة لحم غنم طرية مطبوخة على نار هادئة حتى النضج التام، تقدم فوق أرز العنبر العراقي مع المكسرات والشعرية والصلصة الخاصة.',
      'price': 24000,
      'image_url':
          'https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 25,
      'is_available': true,
      'rating': 4.9,
    },
    {
      'id': 'item_6',
      'category_id': 'cat_main',
      'name': 'دولمة بغدادية مشكلة',
      'description':
          'دولمة عراقية حامضة حلوة محشوة بالأرز واللحم المفروم والبهارات مع ورق العنب، البصل، الباذنجان، والكوسا مع أضلاع اللحم.',
      'price': 18000,
      'image_url':
          'https://images.unsplash.com/photo-1628294895950-9805252327bc?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 30,
      'is_available': true,
      'rating': 4.9,
    },
    {
      'id': 'item_7',
      'category_id': 'cat_main',
      'name': 'سمك مسكوف عراقي',
      'description':
          'سمك الشبوط البغدادي الشهير مشوي على خشب الطرفاء بطريقة المسكوف التقليدية مع الصلصة والتوابل العراقية والليمون والطرشي.',
      'price': 28000,
      'image_url':
          'https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 35,
      'is_available': true,
      'rating': 5.0,
    },
    {
      'id': 'item_8',
      'category_id': 'cat_main',
      'name': 'برياني دجاج ملكي',
      'description':
          'أرز بسمتي مبهر ببهارات البرياني الهندية والعراقية الغنية، يقدم مع نصف دجاجة محمرة ومزينة بالمكسرات واللوز والزبيب.',
      'price': 15000,
      'image_url':
          'https://images.unsplash.com/photo-1589302168068-964664d93dc0?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 20,
      'is_available': true,
      'rating': 4.8,
    },

    // مقبلات
    {
      'id': 'item_9',
      'category_id': 'cat_appetizers',
      'name': 'حمص بطحينة وزيت زيتون',
      'description':
          'حمص مهروس ناعم ممزوج بالطحينة الصافية وعصير الليمون الطازج، مغطى بزيت الزيتون البكر الممتاز وحبات الصنوبر المحمصة.',
      'price': 5000,
      'image_url':
          'https://images.unsplash.com/photo-1577906096429-f73c2c312435?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 10,
      'is_available': true,
      'rating': 4.7,
    },
    {
      'id': 'item_10',
      'category_id': 'cat_appetizers',
      'name': 'متبل باذنجان مدخن',
      'description':
          'باذنجان مشوي على الفحم ومهروس مع الطحينة والثوم والليمون، بنكهة مدخنة فاخرة وزيت زيتون.',
      'price': 5000,
      'image_url':
          'https://images.unsplash.com/photo-1541518763669-27fef04b14ea?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 10,
      'is_available': true,
      'rating': 4.8,
    },
    {
      'id': 'item_11',
      'category_id': 'cat_appetizers',
      'name': 'كبة حلب مقرمشة (٤ قطع)',
      'description':
          'كبة برغل مقرمشة محشوة باللحم المفروم والبصل واللوز مع البهارات العراقية الخاصة.',
      'price': 7000,
      'image_url':
          'https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 15,
      'is_available': true,
      'rating': 4.9,
    },

    // ساندويش
    {
      'id': 'item_12',
      'category_id': 'cat_sandwiches',
      'name': 'شاورما لحم عراقي بالصمون الحجري',
      'description':
          'شرائح لحم عجل وغنم طازج متبلة بالبهارات الخاصة، تقدم في الصمون العراقي الحجري مع الطماطم والبيواز وصلصة الطحينة.',
      'price': 7000,
      'image_url':
          'https://images.unsplash.com/photo-1561651823-34feb02250e4?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 12,
      'is_available': true,
      'rating': 4.8,
    },
    {
      'id': 'item_13',
      'category_id': 'cat_sandwiches',
      'name': 'ساندويش كباب بالخبز العراقي',
      'description':
          'سيخ كباب لحم مشوي طازج ملفوف بخبز التنور الساخن مع السماق والخضار والطرشي المدبس.',
      'price': 6000,
      'image_url':
          'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 12,
      'is_available': true,
      'rating': 4.7,
    },

    // شوربات
    {
      'id': 'item_14',
      'category_id': 'cat_soups',
      'name': 'شوربة عدس بغدادية مع خبز محمص',
      'description':
          'شوربة العدس الأصفر التقليدية الغنية بنكهة الكمون والليمون، تقدم ساخنة مع مكعبات الخبز المحمص وشرائح الليمون.',
      'price': 4000,
      'image_url':
          'https://images.unsplash.com/photo-1547592166-23ac45744acd?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 10,
      'is_available': true,
      'rating': 4.9,
    },

    // حلويات
    {
      'id': 'item_15',
      'category_id': 'cat_sweets',
      'name': 'كنافة نابلسية بالجبن الفاخر',
      'description':
          'كنافة ساخنة بجبنة عكاوية ذائبة ومطاطية، مسقية بالقطر المعطر بماء الورد ومزينة بالفستق الحلبي المطحون.',
      'price': 6500,
      'image_url':
          'https://images.unsplash.com/photo-1587314168485-3236d6710814?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 15,
      'is_available': true,
      'rating': 4.9,
    },
    {
      'id': 'item_16',
      'category_id': 'cat_sweets',
      'name': 'تشكيلة بقلاوة بالفستق والقشطة',
      'description':
          'طبقات مقرمشة وهشة من عجينة الفيلو المحشوة بالفستق الحلبي الفاخر والمشبعة بالقطر والسمن البلدي.',
      'price': 7500,
      'image_url':
          'https://images.unsplash.com/photo-1519869325930-281384150729?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 8,
      'is_available': true,
      'rating': 4.8,
    },

    // مشروبات
    {
      'id': 'item_17',
      'category_id': 'cat_drinks',
      'name': 'شاي عراقي مهيل مخدر في الاستكان',
      'description':
          'شاي سيلاني فاخر مخدر على الفحم بنكهة الهيل العطرة، يقدم في الاستكان البغدادي الأصيل مع السكر حسب الرغبة.',
      'price': 1500,
      'image_url':
          'https://images.unsplash.com/photo-1576092768241-dec231879fc3?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 5,
      'is_available': true,
      'rating': 5.0,
    },
    {
      'id': 'item_18',
      'category_id': 'cat_drinks',
      'name': 'عصير رمان طبيعي طازج',
      'description':
          'عصير رمان طبيعي ١٠٠٪ معصور طازجاً بدون أي إضافات أو سكر مضاف، منعش ومفعم بالفوائد.',
      'price': 4000,
      'image_url':
          'https://images.unsplash.com/photo-1621506289937-a8e4df240d0b?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 5,
      'is_available': true,
      'rating': 4.9,
    },
    {
      'id': 'item_19',
      'category_id': 'cat_drinks',
      'name': 'شنينة / لبن أربيل بالنعناع',
      'description':
          'لبن عيران طبيعي مثلج ومملح بخفة مع رشة نعناع مجفف، مشروب منعش ومثالي مع المشاوي.',
      'price': 2500,
      'image_url':
          'https://images.unsplash.com/photo-1540420773420-3366772f4999?auto=format&fit=crop&w=800&q=80',
      'preparation_time': 5,
      'is_available': true,
      'rating': 4.8,
    },
  ];
}
