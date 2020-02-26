.PHONY: all
all: go py dt

.PHONY: go
go:
	protoc --gofast_out=plugins=grpc:go api.proto

.PHONY: py
py:
	python -m grpc_tools.protoc -I. --python_out=py --grpc_python_out=py api.proto

.PHONY: dt
dt:
	# copied from main repo. is not right :)
	protoc empty.proto timestamp.proto wrappers.proto --proto_path=$(LIB_FSPATH)/server/third_party/google/protobuf --plugin=protoc-gen-dart=$(HOME)/.pub-cache/bin/protoc-gen-dart --dart_out=grpc:$(PWD)/lib/api/v1/google/protobuf
	protoc chat.proto --proto_path=$(LIB_FSPATH)/server/api/proto/v1/ --plugin=protoc-gen-dart=$(HOME)/.pub-cache/bin/protoc-gen-dart --dart_out=grpc:$(PWD)/client/lib/chat_view/api/v1/

