//
//  OCMapViewSampleHelpAnnotation.h
//  openClusterMapView
//
//  Created by Botond Kis on 17.07.11.
//
//

//  Modified by Kevin Manase on 4/11/16
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "OCGrouping.h"

@interface OCSingleAnnotation: NSObject <MKAnnotation, OCGrouping>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *groupTag;

- (id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate;

@end
