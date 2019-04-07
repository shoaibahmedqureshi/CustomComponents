//
//  WeatherForecastControl.swift
//  CustomComponents
//
//  Created by Shoaib Ahmed Qureshi on 4/6/19.
//  Copyright © 2019 Shoaib Ahmed Qureshi. All rights reserved.
//

import UIKit

class WeatherForecastControl: UIView , UIScrollViewDelegate, GalleryCollectionViewDelegate {
 
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var forecastCollectionView: GalleryCollectionView!
    var slides:[Slide] = [];
   
    @IBOutlet var contentView : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        scrollView.delegate = self
       
        forecastCollectionView.delegate = self
        
        slides = createSlides()
        forecastCollectionView.setup(galleryItem:slides , scrollDirection:.horizontal)
        setupSlideScrollView(slides: slides)
        
        pageControl.numberOfPages = slides.count
        pageControl.currentPage = 0
        self.bringSubviewToFront(pageControl)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y != 0 {
            scrollView.contentOffset.y = 0
        }
        let pageIndex = round(scrollView.contentOffset.x/self.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //commonInit()
    }
    
    func createSlides() -> [Slide] {
        
        let slide1:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
           slide1.lbl.text = "Multan"
        
        let slide2:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide2.lbl.text = "Karachi"
        
        let slide3:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
           slide3.lbl.text = "Hyderabad"
        
        let slide4:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.lbl.text = "Lahore"
        
        
        let slide5:Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide5.lbl.text = "Islamabad"
        return [slide1, slide2, slide3, slide4, slide5]
    }
    
    func setupSlideScrollView(slides : [Slide]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        scrollView.contentSize = CGSize(width: self.frame.width * CGFloat(slides.count), height: self.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< slides.count {
            slides[i].frame = CGRect(x: self.frame.width * CGFloat(i), y: 0, width: self.frame.width, height: self.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("WeatherForecastControl", owner:self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
    }
    
    func loadMore() {
        
    }
    
    func didClickGalleryItem(index: Int, selectedCategoryType: String) {
        
    }
    
    func didLongTappedGalleryItem(index: Int, selectedCategoryType: String) {
        
    }


}
