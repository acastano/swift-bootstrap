
import UIKit
import CoreData

open class CollectionViewController: ViewController, NSFetchedResultsControllerDelegate {
    
    open let cellIdentifier = "cellIdentifier"
    open let headerIdentifier = "headerIdentifier"
    open let footerIdentifier = "footerIdentifier"

    fileprivate let queue = OperationQueue()
    fileprivate var sectionChanges = [[NSNumber:NSNumber]]()
    fileprivate var objectChanges = [[NSNumber:[IndexPath]]]()
    
    @IBOutlet open weak var collectionView: UICollectionView!
    
    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        queue.maxConcurrentOperationCount = 0
        
    }
    
    //MARK - NSFetchedResultsControllerDelegate
    
    open func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>){
        
        objectChanges.removeAll(keepingCapacity: false)
        
        sectionChanges.removeAll(keepingCapacity: false)
        
    }
    
    open func controller(_ controller:NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo:NSFetchedResultsSectionInfo, atSectionIndex sectionIndex:Int, for type:NSFetchedResultsChangeType) {
        
        let change = [NSNumber(value: type.rawValue as UInt) : NSNumber(value: sectionIndex as Int)]
        
        sectionChanges.append(change)
        
    }
    
    open func controller(_ controller:NSFetchedResultsController<NSFetchRequestResult>, didChange anObject:Any, at indexPath:IndexPath?, for type:NSFetchedResultsChangeType, newIndexPath:IndexPath?) {
        
        var change = [NSNumber:[IndexPath]]()
        
        let typeNum = NSNumber(value: type.rawValue as UInt)
        
        switch type {
            
        case .delete:
            
            if let indexPath = indexPath {
                
                change[typeNum] = [indexPath]
                
            }
            
        case .update:
            
            if let indexPath = indexPath {
                
                change[typeNum] = [indexPath]
                
            }
            
        case .insert:
            
            if let indexPath = newIndexPath {
                
                change[typeNum] = [indexPath]
                
            }
            
        case .move:
            
            if indexPath != nil && newIndexPath != nil {
                
                change[typeNum] = [indexPath!, newIndexPath!]
                
            }
            
        }
        
        objectChanges.append(change)
        
    }
    
    open func controllerDidChangeContent(_ controller:NSFetchedResultsController<NSFetchRequestResult>) {
        
       collectionView?.reloadData()
        
    }
    
    fileprivate func processChanges() {
        
        collectionView.performBatchUpdates({ [weak self] in
            
            if let sectionChanges = self?.sectionChanges {
                
                for change in sectionChanges {
                    
                    for (key, value) in change {
                        
                        self?.queue.addOperation {
                            
                            let index = IndexSet(integer:value.intValue)
                            
                            if let type = NSFetchedResultsChangeType(rawValue: key.uintValue) {
                                
                                switch type {
                                    
                                case .move:
                                    break
                                    
                                case .update:
                                    break
                                    
                                case .insert:
                                    
                                    self?.collectionView.insertSections(index)
                                    
                                case .delete:
                                    
                                    self?.collectionView.deleteSections(index)
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
            if let objectChanges = self?.objectChanges {
                
                for change in objectChanges {
                    
                    for (key, value) in change {
                        
                        self?.queue.addOperation {
                            
                            if let type = NSFetchedResultsChangeType(rawValue: key.uintValue) {
                                
                                switch type {
                                    
                                case .update:
                                    
                                    self?.collectionView.reloadItems(at: value)
                                    
                                case .insert:
                                    
                                    self?.collectionView.insertItems(at: value)
                                    
                                case .delete:
                                    
                                    self?.collectionView.deleteItems(at: value)
                                    
                                case .move:
                                    
                                    self?.collectionView.moveItem(at: value[0], to: value[1])
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }) { [weak self] finished in
            
            self?.objectChanges.removeAll(keepingCapacity: false)
            
            self?.sectionChanges.removeAll(keepingCapacity: false)
            
        }
        
    }
    
}
