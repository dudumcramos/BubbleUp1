//: A UIKit based Playground for presenting user interface

import UIKit
import PlaygroundSupport

//Contadores
//var countLooks = 0
//var countStyles = 0
var countDiscover = 0

//Arrays
let discoverArray: [Look] = ModelLooks.shared
let allStyles: [Style] = ModelStyles.shared
var myLooksArray: [Look] = []
var myStylesArray: [Style] = []

//Primeira Página - Discovery
class DiscoverViewController : UIViewController {
    
    private var bubbleView = UIImageView()
    private var fundoView = UIImageView()
    
    override func loadView() {
        
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
        
        //Itens em tela
        let like = UIButton(frame: CGRect(x: 242, y: 510, width: 90, height: 90))
        like.setImage(UIImage(named: "likeButton"), for: .normal)
        like.addTarget(nil, action: #selector(tapLike), for: .touchUpInside)
        
        let dislike = UIButton(frame: CGRect(x: 42, y: 510, width: 90, height: 90))
        dislike.setImage(UIImage (named: "dislikeButton"), for: .normal)
        dislike.addTarget(nil, action: #selector(tapDislike), for: .touchUpInside)
        
        let bubbleImage = UIImage(named: discoverArray[countDiscover].disBubble)
        bubbleView = UIImageView(image: bubbleImage)
        bubbleView.frame = CGRect(x: 0, y: 0, width: 375, height: 606)
        
        let fundoImage = UIImage(named: discoverArray[countDiscover].disBackgorund)
        fundoView = UIImageView(image: fundoImage)
        fundoView.frame = CGRect(x: 0, y: 0, width: 375, height: 680)
        
        view.addSubview(fundoView)
        view.addSubview(bubbleView)
        view.addSubview(dislike)
        view.addSubview(like)
        
        self.view = view
    }
    
    //Botão Like
    @objc func tapLike() {
        myLooks.tabBarItem.badgeValue = ""
        myLooks.tabBarItem.badgeColor = #colorLiteral(red: 0.5019607843, green: 0.03137254902, blue: 0.0862745098, alpha: 1)
        myStyles.tabBarItem.badgeValue = ""
        myStyles.tabBarItem.badgeColor = #colorLiteral(red: 0.5019607843, green: 0.03137254902, blue: 0.0862745098, alpha: 1)
        //adicionar Look ao array myLooks
        myLooksArray.append(discoverArray[countDiscover])
        myStylesArray.append(allStyles[countDiscover])
        countDiscover = countDiscover + 1
        if countDiscover == 15 {
            countDiscover = 0
        }
        
        bubbleView.image = UIImage(named: discoverArray[countDiscover].disBubble)
        fundoView.image = UIImage(named: discoverArray[countDiscover].disBackgorund)
    }
    
    //Botão disLike
    @objc func tapDislike() {
        countDiscover = countDiscover + 1
        if countDiscover == 15 {
            countDiscover = 0
        }
        
        bubbleView.image = UIImage(named: discoverArray[countDiscover].disBubble)
        fundoView.image = UIImage(named: discoverArray[countDiscover].disBackgorund)
    }
}

// Segunda Pagina - My Looks Collection View
class myLooksViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    //View da collection
    var myCollectionView:UICollectionView?
    
    override func viewWillAppear(_ animated: Bool) {
        
        //Layout da pagina antes da collection
        let view2 = UIView()
        view2.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
        
        let fundoImage = UIImage(named: "MyLooks_Back")
        let fundoView = UIImageView(image: fundoImage)
        fundoView.frame = CGRect(x: 0, y: 0, width: 375, height: 680)
        view2.addSubview(fundoView)
        
        let topo = UILabel(frame: CGRect(x: 0, y: 0, width: 375, height: 75))
        topo.backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        topo.text = ""
        view2.addSubview(topo)
        
        let mLLabel = UILabel(frame: CGRect(x: 30, y: 26, width: 300, height: 40))
        mLLabel.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        mLLabel.text = "My Looks"
        mLLabel.font = UIFont.boldSystemFont(ofSize: 28)
        view2.addSubview(mLLabel)
        
        //Layout da Collection View
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 60, bottom: 30, right: 60)
        layout.itemSize = CGSize(width: 255, height: 255)
        
        //Inicializando a Collection View
        myCollectionView = UICollectionView(frame: CGRect(x: 0, y: 75, width: 375, height: 570), collectionViewLayout: layout)
        //Utilizando a Cell
        myCollectionView?.register(myLooksCollectionViewCell.self, forCellWithReuseIdentifier: "MinhaCellCustomizada")
        myCollectionView?.backgroundColor = UIColor.white.withAlphaComponent(0)
        myCollectionView?.dataSource = self
        myCollectionView?.delegate = self
        
        view2.addSubview(myCollectionView!)
        
        self.view = view2
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myLooks.tabBarItem.badgeValue = nil
    }
    
    //Colunas de itens
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    //Número de Itens na Collection
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return myLooksArray.count
    }
    
    //Conteúdo da Collection
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MinhaCellCustomizada", for: indexPath) as? myLooksCollectionViewCell
        myCell?.imageView.image = UIImage(named: myLooksArray[indexPath.section].colImage)
        
        myCell?.labelLook.text = myLooksArray[indexPath.section].perName
        myCell?.labelLook.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        
        return myCell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        detalheVC.modalPresentationStyle = .fullScreen
        //: IMPORTANTE: aqui estamos "passando um dado" de um view controller para o outro
        detalheVC.detalheLook = myLooksArray[indexPath.section]
        present(detalheVC, animated: true, completion: nil)
    }
}

//Cell da Collection View
class myLooksCollectionViewCell: UICollectionViewCell {
    
    public let imageView: UIImageView = UIImageView(frame: CGRect(x: 0, y:0, width: 255, height: 255))
    public let labelLook: UILabel = UILabel(frame: CGRect(x:0, y: 258, width:250,height:20))
    
    public override init(frame: CGRect){
        super.init(frame:frame)
        self.addSubview(imageView)
        labelLook.font = UIFont.boldSystemFont(ofSize: 15)
        labelLook.textAlignment = NSTextAlignment.center
        self.addSubview(labelLook)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DetalheViewController: UIViewController {
    //: propriedade que armazenará o objeto cachorro que está sendo exibido
    var detalheLook: Look?
    private var imageView: UIImageView?
    private var labelLook: UILabel?
    private var descricaoLook: UILabel?
    private var estiloIcon: UIImageView?
    private var estiloLabel: UILabel?
    private var ref1IView: UIImageView?
    private var ref2IView: UIImageView?
    private var ref3IView: UIImageView?
    private var ref1Label: UILabel?
    private var ref2Label: UILabel?
    private var ref3Label: UILabel?
    private var loja1IView: UIImageView?
    private var loja2IView: UIImageView?
    private var loja3IView: UIImageView?
    private var loja1Label: UILabel?
    private var loja2Label: UILabel?
    private var loja3Label: UILabel?
    
    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
        view.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
        
        //ScrollView - colocar tudo da view nela e ela na view poe addSubview
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: 375, height: 1080)
        scrollView.setContentOffset(CGPoint(x: 0, y: 60), animated: true)
        
        
        //: inicializando e configurando botão voltar
        let button = UIButton(frame: CGRect(x: 30, y: 15, width: 50, height: 50))
        
        button.setTitle("Voltar", for: .normal)
        button.addTarget(nil, action: #selector(voltar), for: .touchUpInside)
        scrollView.addSubview(button)
        
        imageView = UIImageView(frame: CGRect(x:0, y:60, width:375, height: 450));
        imageView?.contentMode = .scaleAspectFit
        scrollView.addSubview(imageView!)
        
        labelLook = UILabel(frame: CGRect(x: 30, y: 530, width:300, height: 20))
        labelLook?.font = UIFont.boldSystemFont(ofSize: 25)
        labelLook?.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        scrollView.addSubview(labelLook!)
        
        descricaoLook = UILabel(frame: CGRect(x: 40, y: 510, width: 250, height: 150))
        descricaoLook?.font = UIFont.systemFont(ofSize: 15)
        descricaoLook?.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        descricaoLook?.numberOfLines = 3
        scrollView.addSubview(descricaoLook!)
        
        estiloIcon = UIImageView(frame: CGRect(x: 35, y: 650, width: 50, height: 50))
        estiloIcon?.contentMode = .scaleAspectFit
        scrollView.addSubview(estiloIcon!)
        
        let estiloSub = UILabel(frame: CGRect(x: 35, y: 620, width: 300, height: 20))
        estiloSub.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        estiloSub.text = "Estilo"
        estiloSub.font = UIFont.boldSystemFont(ofSize: 20)
        scrollView.addSubview(estiloSub)
        
        estiloLabel = UILabel(frame: CGRect(x: 100, y: 665, width: 120, height: 20))
        estiloLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        estiloLabel?.textAlignment = .left
        estiloLabel?.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        scrollView.addSubview(estiloLabel!)
        
        let referenciaSub = UILabel(frame: CGRect(x: 35, y: 720, width: 300, height: 20))
        referenciaSub.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        referenciaSub.text = "Referências"
        referenciaSub.font = UIFont.boldSystemFont(ofSize: 20)
        scrollView.addSubview(referenciaSub)
        
        ref1IView = UIImageView(frame: CGRect(x: 35, y: 750, width: 95, height: 95))
        ref1IView?.contentMode = .scaleAspectFit
        scrollView.addSubview(ref1IView!)
        
        ref2IView = UIImageView(frame: CGRect(x: 140, y: 750, width: 95, height: 95))
        ref2IView?.contentMode = .scaleAspectFit
        scrollView.addSubview(ref2IView!)
        
        ref3IView = UIImageView(frame: CGRect(x: 245, y: 750, width: 95, height: 95))
        ref3IView?.contentMode = .scaleAspectFit
        scrollView.addSubview(ref3IView!)
        
        ref1Label = UILabel(frame: CGRect(x: 35, y: 850, width: 95, height: 15))
        ref1Label?.font = UIFont.systemFont(ofSize: 15)
        ref1Label?.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        ref1Label?.textAlignment = .center
        scrollView.addSubview(ref1Label!)
        
        ref2Label = UILabel(frame: CGRect(x: 140, y: 850, width: 95, height: 15))
        ref2Label?.font = UIFont.systemFont(ofSize: 15)
        ref2Label?.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        ref2Label?.textAlignment = .center
        scrollView.addSubview(ref2Label!)
        
        ref3Label = UILabel(frame: CGRect(x: 245, y: 850, width: 95, height: 15))
        ref3Label?.font = UIFont.systemFont(ofSize: 15)
        ref3Label?.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        ref3Label?.textAlignment = .center
        scrollView.addSubview(ref3Label!)
        
        let lojasSub = UILabel(frame: CGRect(x: 35, y: 885, width: 300, height: 20))
        lojasSub.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        lojasSub.text = "Lojas"
        lojasSub.font = UIFont.boldSystemFont(ofSize: 20)
        scrollView.addSubview(lojasSub)
        
        loja1IView = UIImageView(frame: CGRect(x: 35, y: 915, width: 95, height: 95))
        loja1IView?.contentMode = .scaleAspectFit
        scrollView.addSubview(loja1IView!)
        
        loja2IView = UIImageView(frame: CGRect(x: 140, y: 915, width: 95, height: 95))
        loja2IView?.contentMode = .scaleAspectFit
        scrollView.addSubview(loja2IView!)
        
        loja3IView = UIImageView(frame: CGRect(x: 245, y: 915, width: 95, height: 95))
        loja3IView?.contentMode = .scaleAspectFit
        scrollView.addSubview(loja3IView!)
        
        loja1Label = UILabel(frame: CGRect(x: 35, y: 1015, width: 95, height: 15))
        loja1Label?.font = UIFont.systemFont(ofSize: 15)
        loja1Label?.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        loja1Label?.textAlignment = .center
        scrollView.addSubview(loja1Label!)
        
        loja2Label = UILabel(frame: CGRect(x: 140, y: 1015, width: 95, height: 15))
        loja2Label?.font = UIFont.systemFont(ofSize: 15)
        loja2Label?.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        loja2Label?.textAlignment = .center
        scrollView.addSubview(loja2Label!)
        
        loja3Label = UILabel(frame: CGRect(x: 245, y: 1015, width: 95, height: 15))
        loja3Label?.font = UIFont.systemFont(ofSize: 15)
        loja3Label?.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        loja3Label?.textAlignment = .center
        scrollView.addSubview(loja3Label!)
        
        let bottom = UILabel(frame: CGRect(x: 0, y: 1050, width: 375, height: 1000))
        bottom.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.03137254902, blue: 0.0862745098, alpha: 1)
        bottom.text = ""
        scrollView.addSubview(bottom)
        
        view.addSubview(scrollView)
        
        self.view = view
    }
    
    //: Outra novidade aqui, que tem a ver com o ciclo de vida de ViewControllers. Por quê isso não está no loadView?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let imagem =  UIImage(named: self.detalheLook!.perImage)
        let imagem2 = UIImage(named: self.detalheLook!.estIcon)
        let imagem3 = UIImage(named: self.detalheLook!.ref1Image)
        let imagem4 = UIImage(named: self.detalheLook!.ref2Image)
        let imagem5 = UIImage(named: self.detalheLook!.ref3Image)
        let imagem6 = UIImage(named: self.detalheLook!.loj1Image)
        let imagem7 = UIImage(named: self.detalheLook!.loj2Image)
        let imagem8 = UIImage(named: self.detalheLook!.loj3Image)
        self.imageView?.image = imagem
        self.labelLook?.text = " \(self.detalheLook!.perName)"
        self.descricaoLook?.text = " \(self.detalheLook!.perDescription)"
        self.estiloIcon?.image = imagem2
        self.estiloLabel?.text = "\(self.detalheLook!.estName)"
        self.ref1IView?.image = imagem3
        self.ref2IView?.image = imagem4
        self.ref3IView?.image = imagem5
        self.ref1Label?.text = " \(self.detalheLook!.ref1Profile)"
        self.ref2Label?.text = " \(self.detalheLook!.ref2Profile)"
        self.ref3Label?.text = " \(self.detalheLook!.ref3Profile)"
        self.loja1IView?.image = imagem6
        self.loja2IView?.image = imagem7
        self.loja3IView?.image = imagem8
        self.loja1Label?.text = " \(self.detalheLook!.loj1Profile)"
        self.loja2Label?.text = " \(self.detalheLook!.loj2Profile)"
        self.loja3Label?.text = " \(self.detalheLook!.loj3Profile)"
    }
    
    @objc func voltar() {
        dismiss(animated: true, completion: nil)
    }
    
}

class myStylesViewController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var myStyleCollectionView : UICollectionView?
    
    override func viewWillAppear(_ animated: Bool) {
        
        let view3 = UIView()
        view3.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
        
        let fundoImage = UIImage(named: "MyLooks_Back")
        let fundoView = UIImageView(image: fundoImage)
        fundoView.frame = CGRect(x: 0, y: 0, width: 375, height: 680)
        view3.addSubview(fundoView)
        
        let topo = UILabel(frame: CGRect(x: 0, y: 0, width: 375, height: 75))
        topo.backgroundColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        topo.text = ""
        view3.addSubview(topo)
        
        let mSLabel = UILabel(frame: CGRect(x: 30, y: 26, width: 300, height: 40))
        mSLabel.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        mSLabel.text = "My Styles"
        mSLabel.font = UIFont.boldSystemFont(ofSize: 28)
        view3.addSubview(mSLabel)
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 15, left: 60, bottom: 30, right: 60)
        layout.itemSize = CGSize(width: 255, height: 255)
        
        myStyleCollectionView = UICollectionView(frame: CGRect(x: 0, y: 75, width: 375, height: 570), collectionViewLayout: layout)
        
        myStyleCollectionView?.register(myStylesCollectionViewCell.self, forCellWithReuseIdentifier: "MinhaCellCustomizada")
        myStyleCollectionView?.backgroundColor = UIColor.white.withAlphaComponent(0)
        myStyleCollectionView?.dataSource = self
        myStyleCollectionView?.delegate = self
        
        view3.addSubview(myStyleCollectionView!)
        
        self.view = view3
    }
    
    override func viewDidAppear(_ animated: Bool) {
        myStyles.tabBarItem.badgeValue = nil
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return myStylesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let myCellS = collectionView.dequeueReusableCell(withReuseIdentifier: "MinhaCellCustomizada", for: indexPath) as? myStylesCollectionViewCell
        myCellS?.imageViewStyle.image = UIImage(named: myStylesArray[indexPath.section].colImage)
        
        myCellS?.labelStyle.text = myStylesArray[indexPath.section].perName
        myCellS?.labelStyle.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        
        return myCellS!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        detalheVCStyle.modalPresentationStyle = .fullScreen
        //: IMPORTANTE: aqui estamos "passando um dado" de um view controller para o outro
        detalheVCStyle.detalheStyle = myStylesArray[indexPath.section]
        present(detalheVCStyle, animated: true, completion: nil)
    }
}
class myStylesCollectionViewCell: UICollectionViewCell {
    
    public let imageViewStyle: UIImageView = UIImageView(frame: CGRect(x: 0, y:0, width: 255, height: 255))
    public let labelStyle: UILabel = UILabel(frame: CGRect(x:0, y: 258, width:250,height:20))
    
    public override init(frame: CGRect){
        super.init(frame:frame)
        self.addSubview(imageViewStyle)
        labelStyle.font = UIFont.boldSystemFont(ofSize: 15)
        labelStyle.textAlignment = NSTextAlignment.center
        self.addSubview(labelStyle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class DetalheStyleViewController: UIViewController {
    //: propriedade que armazenará o objeto cachorro que está sendo exibido
    var detalheStyle: Style?
    private var imageViewStyle: UIImageView?
    private var labelStyle: UILabel?
    private var descricaoStyle: UILabel?
    private var ref1IView: UIImageView?
    private var ref2IView: UIImageView?
    private var ref3IView: UIImageView?
    private var ref1Label: UILabel?
    private var ref2Label: UILabel?
    private var ref3Label: UILabel?
    private var loja1IView: UIImageView?
    private var loja2IView: UIImageView?
    private var loja3IView: UIImageView?
    private var loja1Label: UILabel?
    private var loja2Label: UILabel?
    private var loja3Label: UILabel?
    
    override func loadView() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
        view.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.1019607843, blue: 0.1019607843, alpha: 1)
        
        //ScrollView - colocar tudo da view nela e ela na view poe addSubview
        let scrollView = UIScrollView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: 375, height: 1010)
        scrollView.setContentOffset(CGPoint(x: 0, y: 60), animated: true)
        
        //: inicializando e configurando botão voltar
        let button = UIButton(frame: CGRect(x: 30, y: 15, width: 50, height: 50))
        
        button.setTitle("Voltar", for: .normal)
        button.addTarget(nil, action: #selector(voltar), for: .touchUpInside)
        scrollView.addSubview(button)
        
        imageViewStyle = UIImageView(frame: CGRect(x:0, y:60, width:375, height: 450));
        imageViewStyle?.contentMode = .scaleAspectFit
        scrollView.addSubview(imageViewStyle!)
        
        labelStyle = UILabel(frame: CGRect(x: 30, y: 450, width:300, height: 20))
        labelStyle?.font = UIFont.boldSystemFont(ofSize: 25)
        labelStyle?.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        scrollView.addSubview(labelStyle!)
        
        descricaoStyle = UILabel(frame: CGRect(x: 40, y: 430, width: 250, height: 200))
        descricaoStyle?.font = UIFont.systemFont(ofSize: 15)
        descricaoStyle?.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        descricaoStyle?.numberOfLines = 7
        scrollView.addSubview(descricaoStyle!)
        
        let referenciaSub = UILabel(frame: CGRect(x: 35, y: 620, width: 300, height: 20))
        referenciaSub.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        referenciaSub.text = "Referências"
        referenciaSub.font = UIFont.boldSystemFont(ofSize: 20)
        scrollView.addSubview(referenciaSub)
        
        ref1IView = UIImageView(frame: CGRect(x: 35, y: 650, width: 95, height: 95))
        ref1IView?.contentMode = .scaleAspectFit
        scrollView.addSubview(ref1IView!)
        
        ref2IView = UIImageView(frame: CGRect(x: 140, y: 650, width: 95, height: 95))
        ref2IView?.contentMode = .scaleAspectFit
        scrollView.addSubview(ref2IView!)
        
        ref3IView = UIImageView(frame: CGRect(x: 245, y: 650, width: 95, height: 95))
        ref3IView?.contentMode = .scaleAspectFit
        scrollView.addSubview(ref3IView!)
        
        ref1Label = UILabel(frame: CGRect(x: 35, y: 750, width: 95, height: 15))
        ref1Label?.font = UIFont.systemFont(ofSize: 15)
        ref1Label?.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        ref1Label?.textAlignment = .center
        scrollView.addSubview(ref1Label!)
        
        ref2Label = UILabel(frame: CGRect(x: 140, y: 750, width: 95, height: 15))
        ref2Label?.font = UIFont.systemFont(ofSize: 15)
        ref2Label?.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        ref2Label?.textAlignment = .center
        scrollView.addSubview(ref2Label!)
        
        ref3Label = UILabel(frame: CGRect(x: 245, y: 750, width: 95, height: 15))
        ref3Label?.font = UIFont.systemFont(ofSize: 15)
        ref3Label?.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        ref3Label?.textAlignment = .center
        scrollView.addSubview(ref3Label!)
        
        let lojasSub = UILabel(frame: CGRect(x: 35, y: 815, width: 300, height: 20))
        lojasSub.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        lojasSub.text = "Lojas"
        lojasSub.font = UIFont.boldSystemFont(ofSize: 20)
        scrollView.addSubview(lojasSub)
        
        loja1IView = UIImageView(frame: CGRect(x: 35, y: 845, width: 95, height: 95))
        loja1IView?.contentMode = .scaleAspectFit
        scrollView.addSubview(loja1IView!)
        
        loja2IView = UIImageView(frame: CGRect(x: 140, y: 845, width: 95, height: 95))
        loja2IView?.contentMode = .scaleAspectFit
        scrollView.addSubview(loja2IView!)
        
        loja3IView = UIImageView(frame: CGRect(x: 245, y: 845, width: 95, height: 95))
        loja3IView?.contentMode = .scaleAspectFit
        scrollView.addSubview(loja3IView!)
        
        loja1Label = UILabel(frame: CGRect(x: 35, y: 945, width: 95, height: 15))
        loja1Label?.font = UIFont.systemFont(ofSize: 15)
        loja1Label?.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        loja1Label?.textAlignment = .center
        scrollView.addSubview(loja1Label!)
        
        loja2Label = UILabel(frame: CGRect(x: 140, y: 945, width: 95, height: 15))
        loja2Label?.font = UIFont.systemFont(ofSize: 15)
        loja2Label?.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        loja2Label?.textAlignment = .center
        scrollView.addSubview(loja2Label!)
        
        loja3Label = UILabel(frame: CGRect(x: 245, y: 945, width: 95, height: 15))
        loja3Label?.font = UIFont.systemFont(ofSize: 15)
        loja3Label?.textColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)
        loja3Label?.textAlignment = .center
        scrollView.addSubview(loja3Label!)
        
        let bottom = UILabel(frame: CGRect(x: 0, y: 980, width: 375, height: 1000))
        bottom.backgroundColor = #colorLiteral(red: 0.5019607843, green: 0.03137254902, blue: 0.0862745098, alpha: 1)
        bottom.text = ""
        scrollView.addSubview(bottom)
        
        view.addSubview(scrollView)
        
        self.view = view
    }
    
    //: Outra novidade aqui, que tem a ver com o ciclo de vida de ViewControllers. Por quê isso não está no loadView?
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let imagem =  UIImage(named: self.detalheStyle!.perImage)
        let imagem3 = UIImage(named: self.detalheStyle!.ref1Image)
        let imagem4 = UIImage(named: self.detalheStyle!.ref2Image)
        let imagem5 = UIImage(named: self.detalheStyle!.ref3Image)
        let imagem6 = UIImage(named: self.detalheStyle!.loj1Image)
        let imagem7 = UIImage(named: self.detalheStyle!.loj2Image)
        let imagem8 = UIImage(named: self.detalheStyle!.loj3Image)
        self.imageViewStyle?.image = imagem
        self.labelStyle?.text = " \(self.detalheStyle!.perName)"
        self.descricaoStyle?.text = " \(self.detalheStyle!.perDescription)"
        self.ref1IView?.image = imagem3
        self.ref2IView?.image = imagem4
        self.ref3IView?.image = imagem5
        self.ref1Label?.text = " \(self.detalheStyle!.ref1Profile)"
        self.ref2Label?.text = " \(self.detalheStyle!.ref2Profile)"
        self.ref3Label?.text = " \(self.detalheStyle!.ref3Profile)"
        self.loja1IView?.image = imagem6
        self.loja2IView?.image = imagem7
        self.loja3IView?.image = imagem8
        self.loja1Label?.text = " \(self.detalheStyle!.loj1Profile)"
        self.loja2Label?.text = " \(self.detalheStyle!.loj2Profile)"
        self.loja3Label?.text = " \(self.detalheStyle!.loj3Profile)"
    }
    
    @objc func voltar() {
        dismiss(animated: true, completion: nil)
    }
    
}

let detalheVC = DetalheViewController()
let detalheVCStyle = DetalheStyleViewController()
// Present the view controller in the Live View window
let discover = DiscoverViewController()
discover.title = "Discover"

let myLooks = myLooksViewController()
myLooks.title = "My Looks"

let myStyles = myStylesViewController()
myStyles.title = "My Styles"

let viewControllers = [discover, myLooks, myStyles]

let tabBarController = UITabBarController()
tabBarController.viewControllers = viewControllers
tabBarController.tabBar.tintColor = #colorLiteral(red: 0.5019607843, green: 0.03137254902, blue: 0.0862745098, alpha: 1)
tabBarController.tabBar.barTintColor = #colorLiteral(red: 0.9019607843, green: 0.9019607843, blue: 0.9019607843, alpha: 1)

//let vc = DiscoverViewController(screenType: .iphone11Pro, isPortrait: true)
//PlaygroundPage.current.liveView = vc.scale(to: 0.75)
PlaygroundPage.current.liveView = tabBarController
