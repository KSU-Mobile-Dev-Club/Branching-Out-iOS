//
//  OCMapViewSampleHelpAnnotation.m
//  openClusterMapView
//
//  Created by Botond Kis on 17.07.11.
//
//  OCSingleAnnotation.h
//  Modified by Kevin Manase on 4/11/16

#import "OCSingleAnnotation.h"

@implementation OCSingleAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)aCoordinate
{
    self = [super init];
    if (self) {
        _coordinate = aCoordinate;
    }
    return self;
}

#pragma mark equality

- (BOOL)isEqual:(OCSingleAnnotation*)annotation;
{
    if (![annotation isKindOfClass:[OCSingleAnnotation class]]) {
        return NO;
    }
    
    return (self.coordinate.latitude == annotation.coordinate.latitude &&
            self.coordinate.longitude == annotation.coordinate.longitude &&
            [self.title isEqualToString:annotation.title] &&
            [self.subtitle isEqualToString:annotation.subtitle] &&
            [self.groupTag isEqualToString:annotation.groupTag]);
}

@end
