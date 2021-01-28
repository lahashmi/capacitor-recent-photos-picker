declare global {
  interface PluginRegistry {
    RecentPhotosPicker: RecentPhotosPickerPlugin;
  }
}

export interface RecentPhotosPickerPlugin {
  getRecentPhotos(): Promise<any>;
}
