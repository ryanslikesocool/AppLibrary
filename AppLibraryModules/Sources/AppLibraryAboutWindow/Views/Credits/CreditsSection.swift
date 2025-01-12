import AppLibraryResources
import SwiftUI

struct CreditsSection: View {
	public init() { }

	public var body: some View {
		VStack {
			CreditsListLink(.credits.section.contributors.title)
			CreditsListLink(.credits.section.acknowledgements.title)
		}
	}
}
