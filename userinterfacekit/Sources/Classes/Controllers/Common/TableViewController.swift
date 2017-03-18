
import UIKit
import CoreData

open class TableViewController: ViewController, NSFetchedResultsControllerDelegate {

    open let cellIdentifier = "cellIdentifier"
    open let headerIdentifier = "headerIdentifier"

    @IBOutlet open weak var tableView: UITableView!

    open override func viewDidLoad() {
        
        super.viewDidLoad()
        
        #if os(iOS)
        tableView?.separatorColor = UIColor.clear
        #endif
        
        tableView?.backgroundColor = UIColor.clear
        
    }

    //MARK: NSFetchedResultsControllerDelegate
    
    open func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.beginUpdates()
        
    }
    
    open func controller(_ controller:NSFetchedResultsController<NSFetchRequestResult>, didChange anObject:Any, at indexPath:IndexPath?, for type:NSFetchedResultsChangeType, newIndexPath:IndexPath?) {
    
        switch(type) {
            
        case .insert:
            
            if let newIndexPath = newIndexPath {
                
                tableView.insertRows(at: [newIndexPath], with:.fade)
                
            }
            
        case .delete:
            
            if let indexPath = indexPath {
                
                tableView.deleteRows(at: [indexPath], with:.fade)
                
            }
            
        case .update:
            break
            
        case .move:
            
            if let newIndexPath = newIndexPath {
                
                tableView.insertRows(at: [newIndexPath], with:.fade)
                
            }
            
            if let indexPath = indexPath {
                
                tableView.deleteRows(at: [indexPath], with:.fade)
                
            }
            
        }
        
    }
    
    open func controller(_ controller:NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo:NSFetchedResultsSectionInfo, atSectionIndex sectionIndex:Int, for type:NSFetchedResultsChangeType) {
        
        switch(type) {
            
        case .move:
            break
            
        case .update:
            break
            
        case .insert:
            
            tableView.insertSections(IndexSet(integer:sectionIndex), with:.fade)
            
        case .delete:
            
            tableView.deleteSections(IndexSet(integer:sectionIndex), with:.fade)
            
        }
        
    }
    
    open func controllerDidChangeContent(_ controller:NSFetchedResultsController<NSFetchRequestResult>) {
        
        tableView.endUpdates()
        
    }

}
