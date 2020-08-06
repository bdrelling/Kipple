// Copyright © 2020 Brian Drelling. All rights reserved.

#if canImport(SwiftUI)

    import SwiftUI

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    public struct GridStack<Data, ID, Content>: View, DynamicViewContent where Data: RandomAccessCollection, ID: Hashable, Content: View {
        /// The collection of underlying identified data.
        public let data: Data

        /// The hashable identifier of a data element.
        private let id: KeyPath<Data.Element, ID>

        /// A function that can be used to generate content on demand given
        /// underlying data.
        private let content: (Data.Element) -> Content

        /// The number of columns in the grid.
        private let columns: Int

        /// The numbers of rows in the grid.
        private let rows: Int

        /// The spacing between the elements. This value is applied to all `VStack` and `HStack` views.
        private let spacing: CGFloat

        /// Creates an instance that uniquely identifies views across updates based
        /// on the `id` key path to a property on an underlying data element.
        ///
        /// It's important that the ID of a data element does not change unless the
        /// data element is considered to have been replaced with a new data
        /// element with a new identity. If the ID of a data element changes, then
        /// the content view generated from that data element will lose any current
        /// state and animations.
        public init(_ data: Data, id: KeyPath<Data.Element, ID>, columns: Int, spacing: CGFloat = 0, content: @escaping (Data.Element) -> Content) {
            self.data = data
            self.id = id
            self.content = content
            self.spacing = spacing

            self.columns = columns
            self.rows = Int(ceil(Double(self.data.count) / Double(self.columns)))
        }

        public var body: some View {
            VStack(alignment: .leading, spacing: self.spacing) {
                ForEach(0 ..< self.rows) { row in
                    HStack(spacing: self.spacing) {
                        ForEach(0 ..< self.columns(for: row)) { column in
                            self.content(row: row, column: column)
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }

                        ForEach(0 ..< self.emptySpaces(for: row)) { _ in
                            Spacer()
                                .frame(minWidth: 0, maxWidth: .infinity)
                        }
                    }
                }
            }
        }

        private func columns(for row: Int) -> Int {
            let emptySpaces = self.emptySpaces(for: row)

            return min(self.columns, self.columns - emptySpaces)
        }

        private func emptySpaces(for row: Int) -> Int {
            // The total number of elements for all rows up to (and including) this one
            let totalElements = (row + 1) * self.columns

            // Get the number of empty spaces left over if we exceed the element count
            let emptySpaces = totalElements - self.data.count

            // You can't have negative empty spaces
            return max(0, emptySpaces)
        }

        private func content(row: Int, column: Int) -> Content? {
            if let index = self.index(row: row, column: column) {
                return self.content(self.data[index])
            } else {
                return nil
            }
        }

        private func index(row: Int, column: Int) -> Data.Index? {
            let index = self.data.index(self.data.startIndex, offsetBy: (row * self.columns) + column)

            guard self.data.indices.contains(index) else {
                return nil
            }

            return index
        }
    }

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    extension GridStack where ID == Data.Element.ID, Data.Element: Identifiable {
        /// Creates an instance that uniquely identifies views across updates based
        /// on the identity of the underlying data element.
        ///
        /// It's important that the ID of a data element does not change unless the
        /// data element is considered to have been replaced with a new data
        /// element with a new identity. If the ID of a data element changes, then
        /// the content view generated from that data element will lose any current
        /// state and animations.
        public init(_ data: Data, columns: Int, spacing: CGFloat = 0, @ViewBuilder content: @escaping (Data.Element) -> Content) {
            self.init(data, id: \.id, columns: columns, spacing: spacing, content: content)
        }
    }

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    extension GridStack where Data == Range<Int>, ID == Int {
        /// Creates an instance that computes views on demand over a *constant*
        /// range.
        ///
        /// This instance only reads the initial value of `data` and so it does not
        /// need to identify views across updates.
        ///
        /// To compute views on demand over a dynamic range use
        /// `ForEach(_:id:content:)`.
        public init(_ data: Range<Int>, columns: Int, spacing: CGFloat = 0, @ViewBuilder content: @escaping (Int) -> Content) {
            self.init(data, id: \.self, columns: columns, spacing: spacing, content: content)
        }
    }

    @available(iOS 13.0, macOS 10.15, tvOS 13.0, watchOS 6.0, *)
    struct GridStack_Previews: PreviewProvider {
        private static let names = ["Alice", "Bob", "Carl", "Delia", "Erkel"]

        static var previews: some View {
            Group {
                ZStack {
                    GridStack(self.names, id: \.self, columns: 2) { name in
                        Text(name)
                    }
                }

                ZStack {
                    GridStack(self.names, id: \.self, columns: 3) { name in
                        Text(name)
                    }
                }
            }.previewLayout(.sizeThatFits)
        }
    }

#endif
