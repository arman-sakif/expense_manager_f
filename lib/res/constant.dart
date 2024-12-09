

class Constant {

  //WebViews
  static const int emptyIndex = 0;
  static const int firstIndex = 1;
  static const int secondIndex = 2;
  static const int thirdIndex = 3;

  ///parent details pageValue
  ///  // pageValueController.parentDetailsPageValue =1;
  static const int childToParent = 0;
  static const int parentListToParent = 1;
  ///child details pageValue
  static const int parentToChild = 2;
  static const int childListToChild = 1;
  static const int searchToChild = 1;


  static const int childAddPhotoValue = 1;
  static const int parentAddPhotoValue = 0;
  static const int outsideFatherAddPhotoValue = 2;
  static const int filterParentPageValue = 2;
  // static const int

  static const int fifteenDaysValue = 0;
  static const int thirtyDaysValue = 1;
  static const int fortyFiveDaysValue = 2;

  static const int confirmOverviewPage = 0;
  static const int detailsPage = 1;
  static const double mobileBreakpoint = 600;

  // Routing to pedigree form page values
  static const int fromOutsideFather = 1;
  static const int fromParents = 0;

  // Mating Time Limit Constants
  static const int limitAfterEndDate = 70;
  static const int limitAfterCreatedAt = 15;

  // parent breeding year limit
  static const int limitForBreedingInDays = 7*365;



  // Width for mobile layout

  static const List<String> items = [
    "シャム",
    "ブリティッシュショートヘア",
    "メインクーン",
    "ペルシャ",
    "ラグドール",
    "スフィンクス",
    "アビシニアン",
    "アメリカンショートヘア",
    "ノルウェージャン",
    "※選択肢一覧が続く",
  ];


  // Font sizes
  static const double smallFontSize = 12.0;
  static const double mediumFontSize = 17.0;
  static const double largeFontSize = 20.0;

  // Function to get appropriate font size based on screen width
  static double getFontSize(double screenWidth) {
    if (screenWidth < 360) {
      return smallFontSize; // Small screens
    } else if (screenWidth < 720) {
      return mediumFontSize; // Medium screens
    } else {
      return largeFontSize; // Large screens
    }
  }


  static const String termsConditionText = "プライバシーポリシー\n\n一般社団法人 ペットパーク流通協会（以下，「当協会」といいます。）は，ウェブサイトおよびアプリ上で提供するサービス（以下,「本サービス」といいます。）における，ユーザーの個人情報を含む利用情報の取扱いについて，以下のとおりプライバシーポリシー（以下，「本ポリシー」といいます。）を定めます。\n\n第1条（個人情報および利用情報の取得）\n　当協会は本サービスの利用を通じてユーザーが入力した個人情報、および利用情報を取得します。\n・個人情報には、氏名，住所，電話番号，連絡先、各パークにおける会員情報、その他の記述等により特定の個人を識別できる情報及びプロフィール画像等も含まれます。\n・利用情報とは、本サービスの利用を通じてユーザーが入力したテキスト、画像情報を指します。具体的には登録した犬猫に関する生体情報や写真情報等を指します。\n\n第2条（個人情報および利用情報の使用目的）\n当協会が個人情報を収集・利用する目的は，以下のとおりです。\n・本サービスの提供・運営のため\n・本サービスの更新情報、メンテナンス、重要事項のお知らせ等必要に応じたご連絡のため\n・本サービスに関する問い合わせに回答するため（本人確認を行うことを含む）\n・生体の取引（販売や譲渡）時に必要な記録の確認のため\n・当協会に属する全国のペットパーク（以下、「各パーク」といいます。）への所属状況の確認のため\n・当協会の提供するサービスやイベント、キャンペーン等のご案内のため\n・本サービスに記録の登録がある生体の所有者からの問い合わせに対応するため\n・国の機関もしくは地方公共団体またはその委託を受けた者からの問い合わせに対応するため\n・利用規約に違反したユーザーや不正利用しようとするユーザーの特定，および利用の停止または消去（以下、「利用停止等」といいます。）をするため\n・上記の利用目的に付随する目的\n\n第3条（個人情報および利用情報の第三者提供）\n当協会は，次に掲げる場合を除いて，あらかじめユーザーの同意を得ることなく，第三者に個人情報を提供することはありません。ただし，個人情報保護法その他の法令で認められる場合を除きます。\n・法令に基づく場合\n・国の機関もしくは地方公共団体またはその委託を受けた者が法令の定める事務を遂行することに対して協力する必要がある場合であって，本人の同意を得ることにより当該事務の遂行に支障を及ぼすおそれがあるとき。（動物愛護管理法の観点から、事業者による動物の適正な取扱いがなされているか確認するための情報提供に協力する場合を含みます。）\n・人の生命、身体又は財産の保護のために必要がある場合であって、本人の同意を得ることが困難であるとき\n・公衆衛生の向上又は児童の健全な育成の推進のために特に必要がある場合であって、本人の同意を得ることが困難であるとき\n・当協会が利用目的の達成に必要な範囲内において個人情報の取扱いの全部または一部を委託する場合\n・合併その他の事由による事業の承継に伴って個人情報が提供される場合\n・個人情報を特定の者との間で共同して利用する場合であって，その旨並びに共同して利用される個人情報の項目，共同して利用する者の範囲，利用する者の利用目的および当該個人情報の管理について責任を有する者の氏名または名称について，あらかじめ本人に通知し，または本人が容易に知り得る状態に置いた場合\n\n第4条（個人情報の開示）\n当協会は，本人から個人情報の開示を求められたときは，本人に対し，遅滞なくこれを開示します。ただし，開示することにより次のいずれかに該当する場合は，その全部または一部を開示しないこともあり，開示しない決定をした場合には，その旨を遅滞なく通知します。\n・本人または第三者の生命，身体，財産その他の権利利益を害するおそれがある場合\n・当協会の業務の適正な実施に著しい支障を及ぼすおそれがある場合\n・その他法令に違反することとなる場合\n\n第5条（個人情報の利用停止等）\n・当協会は，本人から，個人情報が利用目的の範囲を超えて取り扱われているという理由，または不正の手段により取得されたものであるという理由により，その利用の停止または消去（以下，「利用停止等」といいます。）を求められた場合には，遅滞なく必要な調査を行います。\n・前項の調査結果に基づき，その請求に応じる必要があると判断した場合には，遅滞なく，当該個人情報の利用停止等を行います。\n・当協会は，前項の規定に基づき利用停止等を行った場合，または利用停止等を行わない旨の決定をしたときは，遅滞なく，これをユーザーに通知します。\n\n第6条（プライバシーポリシーの変更）\n本ポリシーの内容は，法令その他本ポリシーに別段の定めのある事項を除いて，ユーザーに通知することなく，変更することができるものとします。\n当協会が別途定める場合を除いて，変更後のプライバシーポリシーは，本ウェブサイトに掲載したときから効力を生じるものとします。\n\n第7条（お問い合わせ窓口）\n本ポリシーに関するお問い合わせは，本サービスのお問い合わせフォームよりお願いいたします。\n\n制定日　2024年9月1日\n";


}