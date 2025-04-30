## In-App Purchases

### Overview
The app uses in-app purchases to unlock premium features. The implementation follows a clean architecture pattern with clear separation of concerns:

- `PurchaseService`: Handles the actual purchase logic using the in_app_purchase package
- `PurchaseViewModel`: Manages the purchase state and provides methods for the UI
- UI Components: Handle user interactions and display appropriate feedback

### Implementation Details

#### Purchase Service
The `PurchaseService` class is responsible for:
- Initializing the in-app purchase system
- Handling purchase updates through a stream
- Verifying purchases
- Managing purchase restoration
- Providing purchase status updates

Key features:
- Proper error handling and logging
- Purchase verification (should be implemented with backend verification in production)
- Stream-based purchase status updates
- Proper cleanup in dispose method

#### Purchase View Model
The `PurchaseViewModel` class:
- Manages the premium status state
- Persists premium status in settings
- Provides methods for buying premium and restoring purchases
- Handles purchase status updates from the service

#### UI Implementation
Purchase-related UI components should:
- Show appropriate loading states during purchase
- Display clear error messages when purchases fail
- Provide feedback for successful purchases
- Handle purchase restoration
- Retry original actions after successful purchases

### Best Practices
1. Always verify purchases with a backend server in production
2. Handle all possible purchase states (pending, error, purchased, restored)
3. Provide clear feedback to users during the purchase process
4. Implement proper error handling and logging
5. Clean up resources properly (streams, controllers)
6. Test purchases in both development and production environments

### Testing
1. Use test accounts for development
2. Test all purchase scenarios:
   - Successful purchase
   - Failed purchase
   - Cancelled purchase
   - Restore purchases
   - Network errors
3. Verify premium features are properly unlocked
4. Test purchase persistence across app restarts

### Common Issues
1. Store not available
2. Product not found in store
3. Purchase verification failures
4. Network connectivity issues
5. User cancellation
6. Improper cleanup of resources

### Security Considerations
1. Never trust client-side purchase verification
2. Implement server-side purchase verification
3. Secure storage of purchase status
4. Handle purchase restoration properly
5. Protect premium features from unauthorized access 