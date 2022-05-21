//
//  TotalsView.swift
//  JobGet
//
//  Created by Deep Desai on 2022-05-10.
//

import Foundation
import UIKit

class TotalsView: UIView {
    
    // Line seperators
    private var firstSeperator: UIBezierPath?
    private var secondSeperator: UIBezierPath?
    
    // Expenses
    internal let expensesTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = label.font.withSize(20)
        label.text = "Expenses"
        
        return label
    }()
    
    // Expenses totals
    
    internal let expensesTotal: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = label.font.withSize(20)
        label.textAlignment = .center
        
        return label
    }()
    
    // Income
    internal let incomeTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = label.font.withSize(20)
        label.text = "Income"
        return label
    }()
    
    // Income total
    internal let incomeTotal: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = label.font.withSize(20)
        label.textAlignment = .center
        
        return label
    }()
    
    
    // Balance
    internal let balanceTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = label.font.withSize(20)
        label.text = "Balance"
        return label
    } ()
    
    // Balance total
    
    internal let balanceTotal: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = label.font.withSize(20)
        label.textAlignment = .center
        
        return label
    }()
    
    // Balance Progress bar
    
    internal let balanceProgressBar: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.clipsToBounds = true
        progressView.layer.borderWidth = 1
        progressView.trackTintColor = .white
        progressView.tintColor = .systemGray3
        progressView.layer.cornerRadius = progressView.frame.size.height * 3
        return progressView
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureViews() {
        self.backgroundColor = .white
        
        addSubview(expensesTitle)
        addSubview(expensesTotal)
        
        addSubview(incomeTitle)
        addSubview(incomeTotal)
        
        addSubview(balanceTitle)
        addSubview(balanceTotal)
        
        addSubview(balanceProgressBar)
    }
    
    
    // Draws seperation lines between values for the view (as seen on design)
    private func drawLines() {
        firstSeperator = UIBezierPath()
        firstSeperator?.move(to: CGPoint(x: expensesTitle.frame.maxX + 16, y: expensesTitle.frame.minY - 2))
        firstSeperator?.addLine(to: CGPoint(x: expensesTitle.frame.maxX + 16, y: expensesTotal.frame.maxY + 2))
        firstSeperator?.lineWidth = 1
        firstSeperator?.close()
        
        secondSeperator = UIBezierPath()
        secondSeperator?.move(to: CGPoint(x: incomeTitle.frame.maxX + 16, y: incomeTitle.frame.minY - 2))
        secondSeperator?.addLine(to: CGPoint(x: incomeTitle.frame.maxX + 16, y: incomeTotal.frame.maxY + 2))
        secondSeperator?.lineWidth = 1
        secondSeperator?.close()
    }
    
    // adds constraints to views using AutoLayout
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            expensesTitle.trailingAnchor.constraint(equalTo: incomeTitle.safeAreaLayoutGuide.leadingAnchor, constant: -30),
            expensesTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            expensesTotal.topAnchor.constraint(equalTo: expensesTitle.safeAreaLayoutGuide.bottomAnchor, constant: 4),
            expensesTotal.centerXAnchor.constraint(equalTo: expensesTitle.centerXAnchor),
            expensesTotal.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            incomeTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            incomeTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            incomeTotal.topAnchor.constraint(equalTo: incomeTitle.safeAreaLayoutGuide.bottomAnchor, constant: 4),
            incomeTotal.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            incomeTotal.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            balanceTitle.leadingAnchor.constraint(equalTo: incomeTitle.safeAreaLayoutGuide.trailingAnchor, constant: 30),
            balanceTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 24),
            balanceTotal.topAnchor.constraint(equalTo: balanceTitle.safeAreaLayoutGuide.bottomAnchor, constant: 4),
            balanceTotal.centerXAnchor.constraint(equalTo: balanceTitle.centerXAnchor),
            balanceTotal.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        NSLayoutConstraint.activate([
            balanceProgressBar.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            balanceProgressBar.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,constant: -25),
            balanceProgressBar.centerXAnchor.constraint(equalTo: incomeTitle.centerXAnchor),
            balanceProgressBar.widthAnchor.constraint(equalToConstant: self.frame.width - 10),
            balanceProgressBar.topAnchor.constraint(equalTo: incomeTotal.safeAreaLayoutGuide.bottomAnchor, constant: 24),
            balanceProgressBar.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        
    }
    
    // Draws lines seen on designs
    
    override func draw(_ rect: CGRect) {
        self.drawLines()
        UIColor.black.setStroke()
        firstSeperator?.stroke()
        secondSeperator?.stroke()
    }
    
    
    //lines are redrawn when rotating device
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setNeedsDisplay()
        configureConstraints()
    }
}
