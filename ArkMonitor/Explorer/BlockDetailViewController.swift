// Copyright (c) 2016 Ark
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the
// "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge,
// publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
// MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
// FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
// WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit
import SwiftyArk

class BlockDetailViewController: ArkViewController {
    
    fileprivate let block     : Block
    fileprivate var tableView : ArkTableView!
    
    init(_ block: Block) {
        self.block = block
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = NSLocalizedString("Block.Detail", comment: "")
        
        tableView = ArkTableView(CGRect.zero)
        tableView.delegate       = self
        tableView.dataSource     = self
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}

// MARK: UITableViewDelegate
extension BlockDetailViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: _screenWidth, height: 35.0))
        headerView.backgroundColor = ArkPalette.secondaryBackgroundColor
        
        let headerLabel = UILabel(frame: CGRect(x: 12.5, y: 0.0, width: _screenWidth - 12.5, height: 35.0))
        headerLabel.textColor = ArkPalette.highlightedTextColor
        headerLabel.textAlignment = .center
        headerLabel.font = UIFont.systemFont(ofSize: 15.0, weight:  .semibold)
        
        switch section {
        case 0:
            headerLabel.text = NSLocalizedString("Block.BlockID", comment: "")
        case 1:
            headerLabel.text = NSLocalizedString("Block.Height", comment: "")
        case 2:
            headerLabel.text = NSLocalizedString("Block.PreviousBlock", comment: "")
        case 3:
            headerLabel.text = NSLocalizedString("Block.NumberOfTransactions", comment: "")
        case 4:
            headerLabel.text = NSLocalizedString("Block.TotalAmount", comment: "")
        case 5:
            headerLabel.text = NSLocalizedString("Block.TotalFee", comment: "")
        case 6:
            headerLabel.text = NSLocalizedString("Block.RewardsFee", comment: "")
        case 7:
            headerLabel.text = NSLocalizedString("Block.PayloadLength", comment: "")
        case 8:
            headerLabel.text = NSLocalizedString("Block.GeneratorPublicKey", comment: "")
        case 9:
            headerLabel.text = NSLocalizedString("Block.BlockSignature", comment: "")
        default:
            headerLabel.text = NSLocalizedString("Block.Confirmations", comment: "")
        }
        
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 8  {
            return 60.0
        } else if indexPath.section == 9 {
            return 90.0
        }
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
}

// MARK: UITableViewDelegate
extension BlockDetailViewController : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var titleString   = ""
        var numberOfLines = 1
        
        switch indexPath.section {
        case 0:
            titleString = String(block.id)
        case 1:
            titleString = String(block.height)
        case 2:
            titleString = block.previousBlock
        case 3:
            titleString = String(block.numberOfTransactions)
        case 4:
            titleString = String(block.totalAmount)
        case 5:
            titleString = String(block.totalFee)
        case 6:
            titleString = String(block.reward)
        case 7:
            titleString = String(block.payloadLength)
        case 8:
            titleString   = block.generatorPublicKey
            numberOfLines = 2
        case 9:
            titleString = block.blockSignature
            numberOfLines = 4
        default:
            titleString = String(block.confirmations)
        }
        
        let cell = ArkDetailTableViewCell(titleString, numberOfLines: numberOfLines)
        return cell
    }
}

