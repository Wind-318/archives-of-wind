/**
 * @file archived_routers.h
 * @author Wind
 * @date 2023-02-06
 *
 * Copyright 2023 Wind. All rights reserved.
 * Use of this source code is governed by a MIT license that can be found in the LICENSE file.
 *
 */

#pragma once

#include <drogon/drogon.h>

namespace archives {
    namespace routers {
        /**
         * @brief This class is used to handle the request of the bucket.
         *
         */
        class BucketRouter : public drogon::HttpController<BucketRouter> {
        public:
            /**
             * @brief List routers of the bucket.
             *
             */
            METHOD_LIST_BEGIN
            METHOD_ADD(BucketRouter::Download, "/archives/buckets/{bucket_name}", drogon::Get);
            METHOD_ADD(BucketRouter::List, "/archives/buckets/list", drogon::Get);
            METHOD_ADD(BucketRouter::Search, "/archives/buckets/{bucket_name}/search", drogon::Get);
            METHOD_ADD(BucketRouter::Create, "/archives/buckets/{bucket_name}", drogon::Post);
            METHOD_ADD(BucketRouter::Rename, "/archives/buckets/{bucket_name}", drogon::Put);
            METHOD_ADD(BucketRouter::Remove, "/archives/buckets/{bucket_name}", drogon::Delete);
            METHOD_LIST_END

            /**
             * @brief Download all files in the bucket.
             *
             * @param bucket_name: The name of the bucket.
             */
            void Download(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name);
            /**
             * @brief List all buckets.
             *
             */
            void List(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback);
            void Search(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name);
            void Create(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name);
            void Rename(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name);
            void Remove(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name);
        };

        /**
         * @brief This class is used to handle the request of the folder.
         *
         */
        class FolderRouter : public drogon::HttpController<FolderRouter> {
        public:
            METHOD_LIST_BEGIN
            METHOD_ADD(FolderRouter::Download, "/archives/buckets/{bucket_name}/folders/{folder_name}", drogon::Get);
            METHOD_ADD(FolderRouter::List, "/archives/buckets/{bucket_name}/folders/list", drogon::Get);
            METHOD_ADD(FolderRouter::Search, "/archives/buckets/{bucket_name}/folders/{folder_name}/search", drogon::Get);
            METHOD_ADD(FolderRouter::Create, "/archives/buckets/{bucket_name}/folders/{folder_name}", drogon::Post);
            METHOD_ADD(FolderRouter::Upload, "/archives/buckets/{bucket_name}/folders/{folder_name}/upload", drogon::Post);
            METHOD_ADD(FolderRouter::Share, "/archives/buckets/{bucket_name}/folders/{folder_name}/share", drogon::Post);
            METHOD_ADD(FolderRouter::Copy, "/archives/buckets/{bucket_name}/folders/{folder_name}/copy", drogon::Post);
            METHOD_ADD(FolderRouter::Move, "/archives/buckets/{bucket_name}/folders/{folder_name}/move", drogon::Put);
            METHOD_ADD(FolderRouter::Rename, "/archives/buckets/{bucket_name}/folders/{folder_name}", drogon::Put);
            METHOD_ADD(FolderRouter::Remove, "/archives/buckets/{bucket_name}/folders/{folder_name}", drogon::Delete);
            METHOD_LIST_END

            void Download(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name);
            void List(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name);
            void Search(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name);
            void Create(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name);
            void Upload(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name);
            void Share(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name);
            void Copy(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name);
            void Move(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name);
            void Rename(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name);
            void Remove(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name);
        };

        /**
         * @brief This class is used to handle the request of the object.
         *
         */
        class ObjectRouter : public drogon::HttpController<ObjectRouter> {
        public:
            METHOD_LIST_BEGIN
            METHOD_ADD(ObjectRouter::Download, "/archives/buckets/{bucket_name}/folders/{folder_name}/objects/{object_name}", drogon::Get);
            METHOD_ADD(ObjectRouter::List, "/archives/buckets/{bucket_name}/folders/{folder_name}/objects/list", drogon::Get);
            METHOD_ADD(ObjectRouter::Preview, "/archives/buckets/{bucket_name}/folders/{folder_name}/objects/{object_name}/preview", drogon::Get);
            METHOD_ADD(ObjectRouter::Search, "/archives/buckets/{bucket_name}/folders/{folder_name}/objects/{object_name}/search", drogon::Get);
            METHOD_ADD(ObjectRouter::Create, "/archives/buckets/{bucket_name}/folders/{folder_name}/objects/{object_name}", drogon::Post);
            METHOD_ADD(ObjectRouter::Upload, "/archives/buckets/{bucket_name}/folders/{folder_name}/objects/{object_name}/upload", drogon::Post);
            METHOD_ADD(ObjectRouter::Share, "/archives/buckets/{bucket_name}/folders/{folder_name}/objects/{object_name}/share", drogon::Post);
            METHOD_ADD(ObjectRouter::Copy, "/archives/buckets/{bucket_name}/folders/{folder_name}/objects/{object_name}/copy", drogon::Post);
            METHOD_ADD(ObjectRouter::Move, "/archives/buckets/{bucket_name}/folders/{folder_name}/objects/{object_name}/move", drogon::Put);
            METHOD_ADD(ObjectRouter::Rename, "/archives/buckets/{bucket_name}/folders/{folder_name}/objects/{object_name}", drogon::Put);
            METHOD_ADD(ObjectRouter::Remove, "/archives/buckets/{bucket_name}/folders/{folder_name}/objects/{object_name}", drogon::Delete);
            METHOD_ADD(ObjectRouter::Unshare, "/archives/buckets/unshare/{share_id}", drogon::Delete);
            METHOD_LIST_END

            void Download(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name, std::string object_name);
            void List(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name);
            void Preview(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name, std::string object_name);
            void Search(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name, std::string object_name);
            void Create(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name, std::string object_name);
            void Upload(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name, std::string object_name);
            void Share(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name, std::string object_name);
            void Copy(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name, std::string object_name);
            void Move(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name, std::string object_name);
            void Rename(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name, std::string object_name);
            void Remove(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string bucket_name, std::string folder_name, std::string object_name);
            void Unshare(const drogon::HttpRequestPtr &req, std::function<void(const drogon::HttpResponsePtr &)> &&callback, std::string share_id);
        };
    }
}