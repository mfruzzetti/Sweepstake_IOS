/* Copyright (c) 2012 Google Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

//
//  GTLPlusMoment.h
//

// ----------------------------------------------------------------------------
// NOTE: This file is generated from Google APIs Discovery Service.
// Service:
//   Google+ API (plus/v1moments)
// Description:
//   The Google+ API enables developers to build on top of the Google+ platform.
// Documentation:
//   http://developers.google.com/+/api/
// Classes:
//   GTLPlusMoment (0 custom class methods, 6 custom properties)
//   GTLPlusMomentVerb (0 custom class methods, 1 custom properties)

#if GTL_BUILT_AS_FRAMEWORK
  #import "GTL/GTLObject.h"
#else
  #import "GTLObject.h"
#endif

@class GTLPlusItemScope;
@class GTLPlusMomentVerb;

// ----------------------------------------------------------------------------
//
//   GTLPlusMoment
//

@interface GTLPlusMoment : GTLObject

// Identifies this resource as a moment.
@property (copy) NSString *kind;

// The object generated by performing the action on the item
@property (retain) GTLPlusItemScope *result;

// Timestamp of the action (when it occured) in RFC3339 format.
@property (retain) GTLDateTime *startDate;

// The object on which the action was performed
@property (retain) GTLPlusItemScope *target;

// The schema.org activity type
@property (copy) NSString *type;

// The action the user performed
@property (retain) GTLPlusMomentVerb *verb;

@end


// ----------------------------------------------------------------------------
//
//   GTLPlusMomentVerb
//

@interface GTLPlusMomentVerb : GTLObject

// Url name of the verb
@property (copy) NSString *url;

@end
