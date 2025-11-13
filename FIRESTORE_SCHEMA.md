# Firestore Database Schema & Structure

## Overview

This document defines the complete Firestore database structure for the AI Persona Chat App. This schema will be implemented in the backend phase.

---

## Database Collections Hierarchy

```
Firestore (persona-ai-b0d88)
│
├── users/                          [Users collection]
│   └── {userId}/
│       ├── profile/                [User profile document]
│       ├── preferences/            [User preferences]
│       └── conversations/          [User's conversations]
│           └── {conversationId}
│
├── personas/                       [Available AI personas]
│   └── {personaId}/
│       └── [Persona data]
│
├── conversations/                  [All conversations]
│   └── {conversationId}/
│       ├── messages/               [Messages subcollection]
│       │   └── {messageId}
│       └── metadata/               [Conversation metadata]
│
└── analytics/                      [App analytics]
    └── usage_logs/
        └── {logId}
```

---

## Collection: `users`

### Document: `{userId}`

Stores user account information linked to Firebase Auth.

```javascript
{
  uid: string,                          // Firebase Auth UID (Document ID)
  email: string,                        // User email
  displayName: string,                  // User's display name
  photoUrl: string,                     // Profile picture URL
  authProvider: "google" | "password",  // Authentication method
  accountCreatedAt: timestamp,          // Account creation date
  lastSignInAt: timestamp,              // Last login time
  isActive: boolean,                    // Account status
  totalMessagesCount: number,           // Total messages sent
  totalConversations: number,           // Total conversations
  preferredPersonaId: string,           // Last used persona
  metadata: {
    lastUpdated: timestamp,
    platform: "android" | "ios" | "web" | "windows",
    appVersion: string
  }
}
```

**Firestore Rules:**
```
allow read, write: if request.auth.uid == resource.id;
```

---

## Subcollection: `users/{userId}/conversations`

Links user to their conversations.

### Document: `{conversationId}`

```javascript
{
  conversationId: string,               // Unique conversation ID
  personaId: string,                    // Which persona
  personaName: string,                  // Persona name (denormalized for UI)
  startedAt: timestamp,                 // Conversation start time
  lastMessageAt: timestamp,             // Last message time
  messageCount: number,                 // Total messages in this conversation
  isActive: boolean,                    // Is conversation ongoing
  isFavorite: boolean,                  // User marked as favorite
  archived: boolean,                    // Is archived
  title: string,                        // User-given title (optional)
}
```

---

## Collection: `conversations`

### Document: `{conversationId}`

Parent document for conversation metadata.

```javascript
{
  id: string,                           // Conversation ID (Document ID)
  userId: string,                       // Conversation owner
  personaId: string,                    // AI persona ID
  personaName: string,                  // Persona name
  startedAt: timestamp,                 // Created timestamp
  lastUpdatedAt: timestamp,             // Last message timestamp
  messageCount: number,                 // Total messages
  userMessageCount: number,             // User messages only
  aiMessageCount: number,               // AI messages only
  totalTokens: number,                  // Total tokens used (for Gemini API tracking)
  status: "active" | "archived",        // Conversation status
  language: string,                     // Detected language (default: "en")
}
```

**Indexes Required:**
- Composite: `userId` + `lastUpdatedAt` (for sorting conversations)
- Composite: `userId` + `status`

---

## Subcollection: `conversations/{conversationId}/messages`

Stores individual chat messages.

### Document: `{messageId}`

```javascript
{
  id: string,                           // Message ID (Document ID)
  conversationId: string,               // Parent conversation
  userId: string,                       // Message sender (user)
  personaId: string,                    // Persona involved
  content: string,                      // Message text
  isUserMessage: boolean,               // true = user, false = AI
  timestamp: timestamp,                 // Message creation time
  status: "sending" | "sent" | "failed" | "read",
  
  // AI-specific fields (only for AI messages)
  aiMetadata: {
    modelUsed: string,                  // e.g., "gemini-pro"
    tokensUsed: number,                 // Tokens consumed
    finishReason: string,               // Completion reason
    processingTimeMs: number,           // Response time
  },
  
  // Optional fields
  imageUrl: string,                     // Attached image (future)
  imageAnalysisResult: string,          // OCR/vision result (future)
  isEdited: boolean,                    // Was message edited
  editedAt: timestamp,                  // Last edit time
  reactions: {
    "👍": 1,
    "❤️": 2,
    ...                                 // Emoji reactions count
  },
  characterCount: number,               // Message length
  wordCount: number,                    // Word count for analytics
}
```

**Indexes Required:**
- `conversationId` + `timestamp` (for fetching messages in order)
- `userId` + `isUserMessage` (for user analytics)

---

## Collection: `personas`

### Document: `{personaId}`

Stores persona configurations and system prompts.

```javascript
{
  id: string,                           // Persona ID (Document ID)
  name: string,                         // e.g., "The Genius", "The Therapist"
  avatar: string,                       // Path to avatar image
  description: string,                  // Short description
  personality: string,                  // Personality overview
  
  // CRITICAL: System prompt for Gemini API
  systemPrompt: string,                 // Full system prompt for LLM
  
  // Persona characteristics
  traits: string[],                     // List of traits
  expertise: string[],                  // Areas of expertise
  communicationStyle: string,           // How it communicates
  
  // Configuration
  messageLimit: number,                 // Max messages per conversation
  responseLength: "short" | "medium" | "long",
  temperature: number,                  // 0.0-2.0 (Gemini API parameter)
  topK: number,                         // Sampling parameter
  topP: number,                         // Nucleus sampling
  
  // Availability
  isAvailable: boolean,                 // Can be selected
  isPublic: boolean,                    // Visible to all users
  
  // Metadata
  createdAt: timestamp,
  updatedAt: timestamp,
  createdBy: string,                    // Admin who created
  version: number,                      // Version number
  stats: {
    totalConversations: number,
    totalMessages: number,
    averageRating: number,
    userCount: number,
  }
}
```

**Example Documents:**

```javascript
// The Genius
{
  id: "persona_genius",
  name: "The Genius",
  avatar: "assets/avatars/genius_avatar.png",
  description: "A brilliant and quick-witted problem solver",
  systemPrompt: "You are The Genius, a brilliant AI persona...",
  traits: ["Intelligent", "Quick-witted", "Logical", "Creative"],
  expertise: ["Problem-solving", "Analysis", "Science", "Technology"],
  communicationStyle: "Direct and analytical with occasional wit",
  temperature: 0.7,
  isAvailable: true,
  ...
}

// The Therapist
{
  id: "persona_therapist",
  name: "The Therapist",
  avatar: "assets/avatars/therapist_avatar.png",
  description: "A compassionate listener and empathetic guide",
  systemPrompt: "You are The Therapist, a supportive AI persona...",
  traits: ["Empathetic", "Patient", "Understanding", "Supportive"],
  expertise: ["Emotional support", "Active listening", "Advice"],
  communicationStyle: "Warm, supportive, and deeply listening",
  temperature: 0.8,
  isAvailable: true,
  ...
}
```

---

## Collection: `analytics`

### Subcollection: `usage_logs`

Tracks user behavior for analytics.

```javascript
{
  userId: string,
  personaId: string,
  conversationId: string,
  messageId: string,
  action: "message_sent" | "persona_selected" | "conversation_created" | "conversation_cleared",
  timestamp: timestamp,
  duration: number,                     // Time spent in milliseconds
  metadata: {
    platform: string,
    appVersion: string,
    locale: string,
  }
}
```

---

## Security Rules (Firestore)

```javascript
// firestore.rules

rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    
    // Users can only read/write their own profile
    match /users/{userId} {
      allow read, write: if request.auth.uid == userId;
      
      // User's conversations
      match /conversations/{conversationId} {
        allow read, write: if request.auth.uid == userId;
      }
    }
    
    // Conversations
    match /conversations/{conversationId} {
      allow read, write: if request.auth.uid == resource.data.userId;
      
      // Messages in conversation
      match /messages/{messageId} {
        allow read, write: if request.auth.uid == resource.data.userId;
      }
    }
    
    // Personas are public readable
    match /personas/{personaId} {
      allow read: if true;
      allow write: if false; // Only backend/admin can modify
    }
    
    // Analytics (append only for users)
    match /analytics/{document=**} {
      allow read: if request.auth.uid != null;
      allow write: if request.auth.uid != null;
    }
  }
}
```

---

## Data Flow Examples

### Example 1: Create New Conversation

```
User selects "The Mentor" persona
        ↓
Cloud Function: selectPersona()
        ↓
Creates: conversations/{newConversationId}
Creates: users/{userId}/conversations/{newConversationId}
Creates: conversations/{newConversationId}/messages/{initialMessageId}
        ↓
Returns: conversationId + initial message to Flutter app
```

### Example 2: Send and Receive Message

```
User sends message via Flutter app
        ↓
Cloud Function: processChatMessage()
        ↓
1. Store user message in conversations/{conversationId}/messages/{msgId}
2. Call Gemini API with persona's systemPrompt
3. Store AI response in conversations/{conversationId}/messages/{responseId}
4. Update conversations/{conversationId} (lastUpdatedAt, messageCount)
5. Update users/{userId}/conversations/{conversationId} (lastMessageAt)
        ↓
Returns: AI response to Flutter app
```

### Example 3: Fetch Chat History

```
User opens conversation
        ↓
Cloud Function: getChatHistory()
        ↓
Query: conversations/{conversationId}/messages
  - Order by timestamp DESC
  - Limit 50 (pagination)
        ↓
Returns: Array of message objects
        ↓
Flutter app displays messages in reverse (newest at bottom)
```

---

## Denormalization Strategy

To optimize read performance:

1. **Persona Name in Conversations**: Store `personaName` alongside `personaId` to avoid additional reads
2. **User Name in Messages**: Could store user display name for UI rendering
3. **Message Count**: Store in parent conversation doc for quick stats display

**Trade-off**: Slightly larger documents but faster UI rendering.

---

## Indexing Strategy

**Composite Indexes to Create:**

```
conversations collection
  - userId + lastUpdatedAt (sorting user's conversations)
  - userId + status (filtering archived conversations)

messages subcollection
  - conversationId + timestamp (fetching message history)
```

These will be auto-created when you run queries in the backend.

---

## API Quota Monitoring

Track Gemini API usage in `aiMetadata.tokensUsed`:

```dart
// Later in backend
totalTokens += message.aiMetadata.tokensUsed;

// Update conversation
conversations/{conversationId}.totalTokens += tokensUsed;
```

---

## Migration Notes (Future)

If you need to add fields later:

```javascript
// Use default values when reading old documents
const message = await db.collection('conversations')
  .doc(conversationId)
  .collection('messages')
  .doc(messageId)
  .get();

const data = message.data() || {};
const status = data.status || "sent";  // Default for old documents
```

---

## Testing the Schema

Once backend is implemented, verify structure:

```powershell
# View Firestore database in Firebase Console
firebase firestore:view

# Export data for backup (after data is added)
firebase firestore:export ./backups

# Test security rules
firebase emulators:start --only firestore
```

---

This schema is optimized for:
- ✅ Fast message retrieval
- ✅ User privacy (isolated data)
- ✅ Scalability (proper indexing)
- ✅ Analytics (usage tracking)
- ✅ Token cost tracking (Gemini API)

Ready to be implemented in the next backend phase!
