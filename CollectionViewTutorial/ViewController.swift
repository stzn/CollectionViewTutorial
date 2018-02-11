import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let reuseIdentifier = "CollectionViewCell"
    
    let tutorials = [
        Tutorial(imageName: "1", summary: "レッスン1", detail: "レッスン1の説明です。\n読み終わったら次へ進んでください。"),
        Tutorial(imageName: "2", summary: "レッスン2", detail: "レッスン2の説明です。\n読み終わったら次へ進んでください。"),
        Tutorial(imageName: "3", summary: "レッスン3", detail: "レッスン3の説明です。\n読み終わったら次へ進んでください。"),
        Tutorial(imageName: "4", summary: "レッスン4", detail: "レッスン4の説明です。\n以上でレッスンは終了です。")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setPageControl()
        setCollectionView()        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }

    private func setCollectionView() {
        
        collectionView.register(UINib.init(nibName: reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    private func setPageControl() {
        pageControl.currentPage = 0
        pageControl.numberOfPages = tutorials.count
    }
    
    @IBAction func prevButtonTapped(_ sender: Any) {
        let prev = max(0, pageControl.currentPage - 1)
        let index = IndexPath(row: prev, section: 0)
        self.pageControl.currentPage = prev
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func nextButtonTapped(_ sender: Any) {
        let next = min(pageControl.currentPage + 1, tutorials.count - 1)
        let index = IndexPath(row: next, section: 0)
        self.pageControl.currentPage = next
        collectionView.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
}

extension ViewController {
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { _ in
            
            self.collectionView.collectionViewLayout.invalidateLayout()
            let indexPath = IndexPath(row: self.pageControl.currentPage, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        })
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        let index = Int(x / view.frame.width)
        pageControl.currentPage = index
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tutorials.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CollectionViewCell
        
        let item = tutorials[indexPath.item]
        
        cell.configure(tutorial: item)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}
