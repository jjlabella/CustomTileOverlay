//
//  MBTilesDB.m
//  OSMMapKit
//
//  Created by Timothy Wu on 2013/11/4.
//  Copyright (c) 2013年 Timothy Wu. All rights reserved.
//

#import "MBTilesDB.h"
#import "FMDatabase.h"

@interface MBTilesDB()

@property (nonatomic, strong, readwrite) FMDatabase *db;

@end

@implementation MBTilesDB

- (id)initWithDBURL:(NSURL *)dbURL
{
    NSParameterAssert(dbURL);
    self = [super init];
    if (self) {
        self.db = [FMDatabase databaseWithPath:dbURL.path];
        if (![self.db open]) {
            [[NSException
              exceptionWithName:@"FileNotFoundException"
              reason:@"MBTiles file Not Found"
              userInfo:nil] raise];
        }
    }
    return self;
}

- (id)init
{
    self = [super init];
    [[NSException
      exceptionWithName:@"InitShouldNotBeUsed"
      reason:@"Should not be created without MBTiles URL"
      userInfo:nil] raise];
    return self;
}

- (id)initWithURLTemplate:(NSString *)URLTemplate
{
    self = [super init];
    [[NSException
      exceptionWithName:@"InitWithURLTemplateShouldNotBeUsed"
      reason:@"Should not be created without MBTiles URL"
      userInfo:nil] raise];
    return self;
}


#pragma mark - Interface
- (NSData *)tileForZoomLevel:(NSInteger)zoom tileColumn:(NSInteger)x tileRow:(NSInteger) y
{
    
    //this method is using tiles getting from mbtiles
    int column = ((int) (pow(2, zoom) - y) - 1);
    
    FMResultSet *results = [self.db executeQuery:@"select tile_data from tiles where zoom_level = ? and tile_column = ? and tile_row = ?",
                            [NSNumber numberWithInteger:zoom],
                            [NSNumber numberWithInteger:x],
                            [NSNumber numberWithInteger:column]];
    
    NSLog(@"select tile_data from tiles where zoom_level = %ld and tile_column = %ld and tile_row = %d",(long)zoom,(long)x,column);
    
    return [results next] ? [results dataForColumn:@"tile_data"] : nil;
}

@end
