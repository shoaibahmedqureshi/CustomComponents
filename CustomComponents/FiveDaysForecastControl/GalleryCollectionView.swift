//
//  ViewController.swift
//  UICollectionView_p1_Swift
//
//  Created by olxios on 20/11/14.
//  Copyright (c) 2014 olxios. All rights reserved.
//

import UIKit

/**
 This protocol represents Gallery item action delegate methods.
 */
protocol GalleryCollectionViewDelegate {
   
   func didClickGalleryItem(index:Int,selectedCategoryType:String)
   func didLongTappedGalleryItem(index:Int,selectedCategoryType:String)
   func loadMore()   
}

/**
 This class handles resusable custom control which is being used all over the app for Doctor collection .
 */

class GalleryCollectionView : UIView , UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate {
    
   
    @IBOutlet var tbl_buttom_space: NSLayoutConstraint!
    var galleryItems: [AnyObject] = []
    var resuseIdentifier : String = "GalleryItemCollectionViewCell"
    var collectionView : UICollectionView?
    var delegate : GalleryCollectionViewDelegate?
   
    var selectedItemNumber : Int?
    var populatedCategoryType : String?
    var shouldHaveShowAll : Bool?
    var shouldShowOverlay : Bool = false
    var scrollDirection : UICollectionView.ScrollDirection?
   

   
    // MARK: -
    // MARK: - View Lifecycle
   
   /**
    This method handles the setup logic sets the scroll direction inputs the gallry item etc .
    */
   
    func setup (galleryItem : [AnyObject],scrollDirection : UICollectionView.ScrollDirection) {
      self.scrollDirection = scrollDirection
      if(collectionView==nil ) {
         self.initializeCollectionView(scrollDirection: scrollDirection)
      }
      collectionView?.frame = self.bounds
      
      if scrollDirection == .vertical {
       self.configureInsetsOfCollectionViewVertical(collectionView: collectionView!)
    
      }
      else {
         self.configureInsetsOfCollectionViewHorizontal(collectionView: collectionView!)
      }
      self.galleryItems = galleryItem
      if collectionView != nil {
      collectionView!.reloadData()
      }
   
   }

   /**
    This method reloads Collection View Data.
    */
 
   func reloadData () {
      collectionView!.reloadData()
    //  let indexPath = NSIndexPath.init(index: galleryItems.count/2)
      self.collectionView?.setContentOffset(CGPoint.init(x:0,y: 0), animated: false)
      
   }
   
   
   func scrollToIndex(indexPath:IndexPath) {
      if scrollDirection == .vertical {
         self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: false)
      }
      else {
          self.collectionView?.scrollToItem(at: indexPath, at: .right, animated: false)
      }
   }
   
   /**
    This method initializes collection view
    */
   
    func initializeCollectionView (scrollDirection : UICollectionView.ScrollDirection) {
      let flowLayout = UICollectionViewFlowLayout()
      flowLayout.scrollDirection = scrollDirection

       collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)

      let nib = UINib.init(nibName: resuseIdentifier, bundle: nil)
      self.collectionView!.register(GalleryItemCollectionViewCell.self, forCellWithReuseIdentifier:resuseIdentifier)
      self.collectionView!.register(nib, forCellWithReuseIdentifier: resuseIdentifier)
    
      collectionView!.delegate = self
      collectionView!.dataSource = self
      collectionView!.backgroundColor = UIColor.white
      //UIColor.init(red: 235/255, green: 235/255, blue: 241/255, alpha: 1)
      
      let lpgr : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(GalleryCollectionView.longTap(sender:)))
      lpgr.minimumPressDuration = 0.3
      lpgr.delegate = self
      lpgr.delaysTouchesBegan = true
      self.collectionView?.addGestureRecognizer(lpgr)

      
      
      let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GalleryCollectionView.tap(sender:)))
      tapGesture.numberOfTapsRequired = 1
      tapGesture.delegate = self
      collectionView!.addGestureRecognizer(tapGesture)
      
      if(!collectionView!.isDescendant(of: self)){
         self.addSubview(collectionView!)
      }

   }
   
   /**
    This method configures the Insets of collection view in vertical direction
    */
   func configureInsetsOfCollectionViewVertical (collectionView:UICollectionView)
   {
      //let insets = UIEdgeInsets.init(top:0, left: 0, bottom: 300, right: 0)
      let insets = UIEdgeInsets.init(top:0, left: 0, bottom: 0, right: 0)
      collectionView.contentInset = insets
      collectionView.scrollIndicatorInsets = insets
   }
   /**
    This method configures the Insets of collection view in horizontal direction
    */
   func configureInsetsOfCollectionViewHorizontal (collectionView:UICollectionView)
   {
    // let insets = UIEdgeInsets.init(top:0, left: -15, bottom: 0, right: 50)
     let insets = UIEdgeInsets.init(top:0, left: 0, bottom: 0, right: 0)
     collectionView.contentInset = insets
     collectionView.scrollIndicatorInsets = insets
   }
   
    func viewDidLoad() {
      
    }
    
   
    
    // MARK: -
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return galleryItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      
      var cell :GalleryItemCollectionViewCell?=nil
      
      if scrollDirection == .horizontal {
          print("scroll direction horizontal")
      }
      else {
          print("scroll direction vertical") 
      }
      
      cell = self.getCell(indexPath: indexPath as NSIndexPath, array: galleryItems, collectionView: collectionView)
      return cell!
        
    }
   

   /**
    This method handles the single tap on any song/album etc.
    */
   
    @objc func tap(sender : UIGestureRecognizer){
      print("Only tap")
      let selectedIndexPath : NSIndexPath
      let pointInCollectionView: CGPoint = sender.location(in: self.collectionView)
      if collectionView?.indexPathForItem(at: pointInCollectionView) != nil {
         selectedIndexPath = (collectionView?.indexPathForItem(at: pointInCollectionView))! as NSIndexPath
      }
      else {
         return
      }
      if sender.state == .ended {
         print("UIGestureRecognizerStateEnded")
         if populatedCategoryType == nil {
            
             self.delegate?.didClickGalleryItem(index: selectedIndexPath.row,selectedCategoryType: "")
         }
         else {
             self.delegate?.didClickGalleryItem(index: selectedIndexPath.row,selectedCategoryType:populatedCategoryType!)
         }
      }
      else if sender.state == .began {
         print("UIGestureRecognizerStateBegan.")
         //Do Whatever You want on Began of Gesture
      }
   }

   /**
    This method handles the Long tap on any song/album etc.
    */
    @objc func longTap(sender : UIGestureRecognizer){
      print("Long tap")
      let selectedIndexPath : NSIndexPath
      let pointInCollectionView: CGPoint = sender.location(in: self.collectionView)
      if collectionView?.indexPathForItem(at: pointInCollectionView) != nil {
         selectedIndexPath = (collectionView?.indexPathForItem(at: pointInCollectionView))! as NSIndexPath
      }
      else {
         return
      } 
      if sender.state == .ended {
         print("UIGestureRecognizerStateEnded")
         if populatedCategoryType == nil {
            
            self.delegate?.didLongTappedGalleryItem(index: selectedIndexPath.row,selectedCategoryType: "")
         }
         else {
            self.delegate?.didLongTappedGalleryItem(index: selectedIndexPath.row,selectedCategoryType: populatedCategoryType!)
           // self.delegate?.didClickGalleryItem(index,selectedCategoryType:populatedCategoryType!)
         }
      }
      else if sender.state == .began {
         print("UIGestureRecognizerStateBegan.")
         //Do Whatever You want on Began of Gesture
      }
   }
   /**
    This method creates and returns cell.
    */
   func getCell (indexPath:NSIndexPath,array:[AnyObject],collectionView:UICollectionView) -> GalleryItemCollectionViewCell {
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: resuseIdentifier, for: indexPath as IndexPath) as! GalleryItemCollectionViewCell
 
      //cell.lblDay?.text = "Monday"
  


      return cell
   }
   
   
   func getOverlyColor(index:Int) -> UIColor {
     return UIColor.blue
   }
   

   func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
      let size = image.size
      
      let widthRatio  = targetSize.width  / image.size.width
      let heightRatio = targetSize.height / image.size.height
      
      // Figure out what our orientation is, and use that to form the rectangle
      var newSize: CGSize
      if(widthRatio > heightRatio) {
         newSize = CGSize.init(width: size.width * heightRatio, height: size.height * heightRatio)
      } else {
         newSize = CGSize.init(width:size.width * widthRatio,  height:size.height * widthRatio)
      }
      
      // This is the rect that we've calculated out and this is what is actually used below
      let rect = CGRect.init(x: 0, y: 0, width: newSize.width, height: newSize.height) //CGRectMake(0, 0, newSize.width, newSize.height)
      
      // Actually do the resizing to the rect using the ImageContext stuff
      UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
      image.draw(in: rect)
      let newImage = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      
      return newImage!
   }

   
   func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
   }
   

   

    
    // MARK: -
    // MARK: - UICollectionViewDelegate
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
      
   }
   

   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return  CGSize.init(width:50, height:130)

   }

   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    
      let totalCellWidth = 50 * galleryItems.count
      let totalSpacingWidth = 10 * (galleryItems.count - 1)
      let leftInset = (self.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
      let rightInset = leftInset
      return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)

   }

}

