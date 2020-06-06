import Combine
import Foundation

public struct TransactionContext<S: StoreProtocol, A: ActionProtocol> {
  /// The operation that is currently running.
  /// - note: Invoke `context.operation.finish` to signal task completion.
  public let operation: AsyncOperation
  /// The target store for this transaction.
  public let store: S
  /// Last recorded error (or side effects) in this dispatch group.
  public let error: Executor.TransactionGroupError
  /// The current transaction.
  public let transaction: Transaction<A>

  /// Atomically update the store's model.
  public func reduceModel(closure: (inout S.ModelType) -> (Void)) {
    store.reduceModel(transaction: transaction, closure: closure)
  }

  /// Terminates the operation if there was an error raised by a previous action in the following
  /// transaction group.
  public func rejectOnGroupError() -> Bool {
    guard error.lastError != nil else {
      return false
    }
    operation.finish()
    return true
  }

  /// Terminates this operation with an error.
  public func reject(error: Error) {
    self.error.lastError = error
    operation.finish()
  }

  /// Terminates the operation.
  public func fulfill() {
    operation.finish()
  }
}

