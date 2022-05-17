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
    
    internal let incomeTotal: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = label.font.withSize(20)
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
    
    internal let balanceTotal: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = label.font.withSize(20)
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
    
    private func drawLines() {
        firstSeperator = UIBezierPath()
        firstSeperator?.move(to: CGPoint(x: expensesTitle.frame.maxX + 12, y: expensesTitle.frame.minY - 2))
        firstSeperator?.addLine(to: CGPoint(x: expensesTitle.frame.maxX + 12, y: expensesTotal.frame.maxY + 2))
        firstSeperator?.lineWidth = 1
        firstSeperator?.close()
        
        secondSeperator = UIBezierPath()
        secondSeperator?.move(to: CGPoint(x: incomeTitle.frame.maxX + 16, y: incomeTitle.frame.minY - 2))
        secondSeperator?.addLine(to: CGPoint(x: incomeTitle.frame.maxX + 16, y: incomeTotal.frame.maxY + 2))
        secondSeperator?.lineWidth = 1
        secondSeperator?.close()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            expensesTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 42),
            expensesTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            expensesTotal.topAnchor.constraint(equalTo: expensesTitle.bottomAnchor, constant: 4),
            expensesTotal.centerXAnchor.constraint(equalTo: expensesTitle.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            incomeTitle.leadingAnchor.constraint(equalTo: expensesTitle.trailingAnchor, constant: 30 - 4),
            incomeTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            incomeTotal.topAnchor.constraint(equalTo: incomeTitle.bottomAnchor, constant: 4),
            incomeTotal.centerXAnchor.constraint(equalTo: incomeTitle.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            balanceTitle.leadingAnchor.constraint(equalTo: incomeTitle.trailingAnchor, constant: 32 - 4),
            balanceTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            balanceTotal.topAnchor.constraint(equalTo: balanceTitle.bottomAnchor, constant: 4),
            balanceTotal.centerXAnchor.constraint(equalTo: balanceTitle.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            balanceProgressBar.leadingAnchor.constraint(equalTo: expensesTitle.leadingAnchor),
            balanceProgressBar.trailingAnchor.constraint(equalTo: balanceTitle.trailingAnchor),
            balanceProgressBar.topAnchor.constraint(equalTo: incomeTotal.bottomAnchor, constant: 24),
            balanceProgressBar.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        
    }
    
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
